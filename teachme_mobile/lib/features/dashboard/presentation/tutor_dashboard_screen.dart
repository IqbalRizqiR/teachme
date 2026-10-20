import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/dashboard/data/dashboard_api.dart';
import 'package:teachme_mobile/features/dashboard/data/dashboard_dto.dart';

final tutorDashboardProvider = FutureProvider<DashboardDto>(
  (ref) => ref.watch(dashboardApiProvider).getDashboard(),
);

class TutorDashboardScreen extends ConsumerStatefulWidget {
  const TutorDashboardScreen({super.key});

  @override
  ConsumerState<TutorDashboardScreen> createState() =>
      _TutorDashboardScreenState();
}

class _TutorDashboardScreenState extends ConsumerState<TutorDashboardScreen> {
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(const Duration(seconds: 15), (_) {
      ref.invalidate(tutorDashboardProvider);
    });
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _accept(String id) async {
    try {
      await ref.read(bookingApiProvider).acceptBooking(id);
      ref.invalidate(tutorDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking diterima')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menerima booking: $e')),
      );
    }
  }

  Future<void> _reject(String id) async {
    try {
      await ref.read(bookingApiProvider).rejectBooking(id);
      ref.invalidate(tutorDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking ditolak')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menolak booking: $e')),
      );
    }
  }

  String _slotTime(String iso) =>
      DateFormat('EEE, d MMM, HH:mm', 'id_ID')
          .format(DateTime.parse(iso).toLocal());

  String _currency(int amount) => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(amount);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;
    final userName = ref.watch(authControllerProvider).whenOrNull(
          authenticated: (user, role) => user.name,
        ) ??
        'Tutor';
    final dashboard = ref.watch(tutorDashboardProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey, $userName! 🧑‍🏫',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dashboard Mengajar',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () => context.push('/notifications'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              dashboard.when(
                loading: () => _skeleton(),
                error: (error, _) => ErrorState(
                  message: 'Gagal memuat dashboard: $error',
                  onRetry: () => ref.invalidate(tutorDashboardProvider),
                ),
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _statGrid(data, accent, theme),
                    const SizedBox(height: 28),
                    _incomingSection(data, theme),
                    if (data.needsGrading.isNotEmpty) ...[
                      const SizedBox(height: 28),
                      _gradingSection(data, theme),
                    ],
                    const SizedBox(height: 28),
                    _upcomingSection(data, accent, theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
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
      ],
    );
  }

  Widget _statGrid(DashboardDto data, RoleAccent accent, ThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _statCard(
          icon: Icons.calendar_today_rounded,
          iconColor: accent.c600,
          value: '${data.thisWeekSessions}',
          label: 'Sesi Minggu Ini',
          theme: theme,
        ),
        _statCard(
          icon: Icons.account_balance_wallet_rounded,
          iconColor: accent.c600,
          value: _currency(data.earningsThisMonth),
          label: 'Pendapatan Bulan Ini',
          theme: theme,
        ),
        _statCard(
          icon: Icons.star_rounded,
          iconColor: Brand.tertiary,
          value: '${data.ratingAvg.toStringAsFixed(1)} ⭐',
          label: 'Rating Rata-rata',
          subtitle: '(${data.ratingCount} ulasan)',
          theme: theme,
        ),
        _statCard(
          icon: Icons.hourglass_empty_rounded,
          iconColor: Brand.tertiary,
          value: '${data.pendingRequests}',
          label: 'Permintaan Baru',
          subtitle: '${data.pendingRequests} permintaan',
          theme: theme,
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    String? subtitle,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _incomingSection(DashboardDto data, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Permintaan Masuk ⏳', theme),
        const SizedBox(height: 12),
        if (data.incomingBookings.isEmpty)
          Text(
            'Tidak ada permintaan booking baru.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          ...data.incomingBookings.map(
            (b) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b.student?.name ?? 'Murid',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    b.subjectName ?? '-',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
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
                          _slotTime(b.slot.startsAt),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (b.note != null && b.note!.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      b.note!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: theme.colorScheme.onSurfaceVariant,
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
                          onPressed: () => _reject(b.id),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          label: 'Terima',
                          variant: AppButtonVariant.primary,
                          onPressed: () => _accept(b.id),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _gradingSection(DashboardDto data, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Perlu Dinilai 📝', theme),
        const SizedBox(height: 12),
        ...data.needsGrading.map(
          (b) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Brand.tertiary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(Radii.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  b.student?.name ?? 'Murid',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  b.subjectName ?? '-',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.event_available_rounded,
                      size: 15,
                      color: Brand.tertiary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _slotTime(b.slot.endsAt),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: 'Beri Nilai Sekarang',
                    variant: AppButtonVariant.primary,
                    onPressed: () => context.push('/bookings/${b.id}/grade'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _upcomingSection(
    DashboardDto data,
    RoleAccent accent,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Sesi Mendatang 📅', theme),
        const SizedBox(height: 12),
        if (data.upcomingSessions.isEmpty)
          Text(
            'Belum ada sesi mendatang.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          ...data.upcomingSessions.map(
            (b) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b.student?.name ?? 'Murid',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    b.subjectName ?? '-',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: accent.c600,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _slotTime(b.slot.startsAt),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}