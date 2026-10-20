import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/avatar_widget.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/core/widgets/status_badge.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/dashboard/data/dashboard_api.dart';
import 'package:teachme_mobile/features/dashboard/data/dashboard_dto.dart';

class TutorDashboardScreen extends ConsumerStatefulWidget {
  const TutorDashboardScreen({super.key});

  @override
  ConsumerState<TutorDashboardScreen> createState() =>
      _TutorDashboardScreenState();
}

class _TutorDashboardScreenState extends ConsumerState<TutorDashboardScreen> {
  Timer? _pollingTimer;
  Future<DashboardDto>? _dashboardFuture;
  final Set<String> _processingIds = {};

  @override
  void initState() {
    super.initState();
    _fetch();
    _pollingTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) {
        _fetch();
      }
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _fetch() {
    setState(() {
      _dashboardFuture = ref.read(dashboardApiProvider).getDashboard();
    });
  }

  Future<void> _refresh() async {
    final future = ref.read(dashboardApiProvider).getDashboard();
    setState(() {
      _dashboardFuture = future;
    });
    await future;
  }

  Future<void> _acceptBooking(String bookingId) async {
    setState(() => _processingIds.add(bookingId));
    try {
      await ref.read(bookingApiProvider).acceptBooking(bookingId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permintaan booking berhasil diterima')),
        );
        _fetch();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menerima booking: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(bookingId));
      }
    }
  }

  Future<void> _rejectBooking(String bookingId) async {
    setState(() => _processingIds.add(bookingId));
    try {
      await ref.read(bookingApiProvider).rejectBooking(bookingId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permintaan booking telah ditolak')),
        );
        _fetch();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menolak booking: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(bookingId));
      }
    }
  }

  String _formatDateTime(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('d MMM yyyy, HH:mm').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  String _formatTime(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('HH:mm').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  String _formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(dashboardApiProvider);
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;
    final authState = ref.watch(authControllerProvider);
    final userName = authState.whenOrNull(
          authenticated: (user, _) => user.name,
        ) ??
        'Tentor';

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: accent.c600,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, $userName! 🧑‍🏫',
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dashboard Mengajar',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FutureBuilder<DashboardDto>(
                  future: _dashboardFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return _buildSkeleton();
                    }
                    if (snapshot.hasError && !snapshot.hasData) {
                      return ErrorState(
                        message: 'Gagal memuat dashboard: ${snapshot.error}',
                        onRetry: _fetch,
                      );
                    }
                    final data = snapshot.data;
                    if (data == null) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatGrid(data, accent, theme),
                        const SizedBox(height: 28),
                        _buildIncomingBookingsSection(data, theme),
                        if (data.needsGrading.isNotEmpty) ...[
                          const SizedBox(height: 28),
                          _buildNeedsGradingSection(data, theme),
                        ],
                        const SizedBox(height: 28),
                        _buildUpcomingSessionsSection(data, accent, theme),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: List.generate(
            4,
            (_) => const SkeletonLoader(
              width: double.infinity,
              height: 100,
              borderRadius: Radii.lg,
            ),
          ),
        ),
        const SizedBox(height: 28),
        const SkeletonLoader(width: 180, height: 24),
        const SizedBox(height: 12),
        const SkeletonLoader(
          width: double.infinity,
          height: 120,
          borderRadius: Radii.lg,
        ),
        const SizedBox(height: 28),
        const SkeletonLoader(width: 180, height: 24),
        const SizedBox(height: 12),
        const SkeletonLoader(
          width: double.infinity,
          height: 90,
          borderRadius: Radii.lg,
        ),
      ],
    );
  }

  Widget _buildStatGrid(
    DashboardDto data,
    RoleAccent accent,
    ThemeData theme,
  ) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: [
        _buildStatCard(
          title: 'Sesi Minggu Ini',
          value: '${data.thisWeekSessions}',
          icon: Icons.calendar_today_rounded,
          iconColor: accent.c600,
          theme: theme,
        ),
        _buildStatCard(
          title: 'Pendapatan Bulan Ini',
          value: _formatCurrency(data.earningsThisMonth),
          icon: Icons.account_balance_wallet_rounded,
          iconColor: accent.c600,
          theme: theme,
        ),
        _buildStatCard(
          title: 'Rating Rata-rata',
          value: '${data.ratingAvg} ⭐',
          subtitle: '(${data.ratingCount} ulasan)',
          icon: Icons.star_rounded,
          iconColor: Brand.tertiary,
          theme: theme,
        ),
        _buildStatCard(
          title: 'Permintaan Baru',
          value: '${data.pendingRequests}',
          subtitle: '${data.pendingRequests} permintaan',
          icon: Icons.hourglass_empty_rounded,
          iconColor: Brand.tertiary,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
    required ThemeData theme,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(icon, size: 20, color: iconColor),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIncomingBookingsSection(DashboardDto data, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Permintaan Masuk ⏳',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        if (data.incomingBookings.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Tidak ada permintaan booking baru.',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          )
        else
          ...data.incomingBookings.map((b) {
            final isProcessing = _processingIds.contains(b.id);
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AvatarWidget(size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                b.student?.name ?? 'Murid',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                b.subjectName ?? 'Mata Pelajaran',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 15,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${_formatDateTime(b.slot.startsAt)} - ${_formatTime(b.slot.endsAt)}',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (b.note != null && b.note!.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(Radii.sm),
                        ),
                        child: Text(
                          '"${b.note!}"',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Tolak',
                            variant: AppButtonVariant.outlined,
                            isLoading: isProcessing,
                            onPressed: () => _rejectBooking(b.id),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            label: 'Terima',
                            variant: AppButtonVariant.primary,
                            isLoading: isProcessing,
                            onPressed: () => _acceptBooking(b.id),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildNeedsGradingSection(DashboardDto data, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Brand.tertiary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: Brand.tertiary, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.edit_note_rounded, color: Brand.tertiary),
              const SizedBox(width: 8),
              Text(
                'Perlu Dinilai 📝',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Brand.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...data.needsGrading.map(
            (b) => Card(
              color: theme.colorScheme.surface,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AvatarWidget(size: 36),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                b.student?.name ?? 'Murid',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                b.subjectName ?? 'Mata Pelajaran',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Selesai: ${_formatDateTime(b.slot.endsAt)}',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Beri Nilai Sekarang',
                        variant: AppButtonVariant.primary,
                        onPressed: () =>
                            context.push('/bookings/${b.id}/grade'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSessionsSection(
    DashboardDto data,
    RoleAccent accent,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sesi Mendatang 📅',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        if (data.upcomingSessions.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Belum ada sesi mendatang.',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          )
        else
          ...data.upcomingSessions.map(
            (b) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const AvatarWidget(size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.student?.name ?? 'Murid',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            b.subjectName ?? 'Mata Pelajaran',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.event_available_rounded,
                                size: 14,
                                color: accent.c600,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${_formatDateTime(b.slot.startsAt)} - ${_formatTime(b.slot.endsAt)}',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    StatusBadge(status: b.status),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
