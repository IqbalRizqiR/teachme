import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/animated_progress_bar.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/empty_state.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/core/widgets/status_badge.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';
import 'package:teachme_mobile/features/progress/data/certificate_downloader.dart';
import 'package:teachme_mobile/features/progress/data/progress_api.dart';
import 'package:teachme_mobile/features/progress/data/progress_dto.dart';

final enrollmentsProvider = FutureProvider<List<EnrollmentDto>>(
  (ref) => ref.watch(progressApiProvider).getEnrollments(),
);

final progressResponseProvider =
    FutureProvider.family<ProgressResponse, String>(
  (ref, id) => ref.watch(progressApiProvider).getProgress(enrollmentId: id),
);

final bookingHistoryProvider = FutureProvider<PaginatedBookings>(
  (ref) => ref.watch(bookingApiProvider).listBookings(),
);

const _filters = ['Semua', 'Selesai', 'Menunggu', 'Dibayar'];

String? _statusFor(String filter) => switch (filter) {
      'Selesai' => 'COMPLETED',
      'Menunggu' => 'PENDING',
      'Dibayar' => 'PAID',
      _ => null,
    };

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  String? _selectedEnrollmentId;
  String _filter = 'Semua';

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progres Belajar'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Progres'), Tab(text: 'Riwayat')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [_progressTab(), _historyTab()],
      ),
    );
  }

  Widget _progressTab() {
    final enrollmentsAsync = ref.watch(enrollmentsProvider);

    return enrollmentsAsync.when(
      data: (enrollments) {
        if (enrollments.isEmpty) {
          return const EmptyState(
            message: 'Belum ada enrollment. Mulai booking les pertamamu!',
          );
        }

        final selected = enrollments.firstWhere(
          (e) => e.id == _selectedEnrollmentId,
          orElse: () => enrollments.first,
        );

        if (_selectedEnrollmentId != selected.id) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _selectedEnrollmentId != selected.id) {
              setState(() => _selectedEnrollmentId = selected.id);
            }
          });
        }

        final progressAsync = ref.watch(progressResponseProvider(selected.id));

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            _enrollmentChips(enrollments),
            const SizedBox(height: 20),
            progressAsync.when(
              data: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _chartCard(data),
                  const SizedBox(height: 16),
                  _targetCard(data.summary, selected),
                  const SizedBox(height: 16),
                  _certificateCard(selected),
                  const SizedBox(height: 16),
                  _notesSection(data.entries),
                ],
              ),
              loading: _progressSkeleton,
              error: (_, _) => ErrorState(
                message: 'Gagal memuat progres',
                onRetry: () =>
                    ref.invalidate(progressResponseProvider(selected.id)),
              ),
            ),
          ],
        );
      },
      loading: _progressSkeleton,
      error: (_, _) => ErrorState(
        message: 'Gagal memuat enrollment',
        onRetry: () => ref.invalidate(enrollmentsProvider),
      ),
    );
  }

  Widget _enrollmentChips(List<EnrollmentDto> enrollments) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: enrollments.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final enrollment = enrollments[index];
          final isSelected = enrollment.id == _selectedEnrollmentId;
          return ChoiceChip(
            label: Text('${enrollment.subjectName} · ${enrollment.tutorName}'),
            selected: isSelected,
            onSelected: (_) =>
                setState(() => _selectedEnrollmentId = enrollment.id),
            selectedColor: accent.c100,
            backgroundColor: theme.cardTheme.color,
            labelStyle: TextStyle(
              color: isSelected ? accent.c600 : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.full),
              side: BorderSide(
                color: isSelected ? accent.c600 : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _chartCard(ProgressResponse data) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;
    final entries = data.entries;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tren Nilai per Sesi',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: entries.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada sesi yang dinilai.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Brand.neutral,
                        ),
                      ),
                    )
                  : LineChart(
                      _chartData(entries, data.summary.targetScore, accent.c500),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _chartData(
    List<ProgressEntryDto> entries,
    int? targetScore,
    Color color,
  ) {
    final theme = Theme.of(context);
    final sorted = [...entries]
      ..sort((a, b) => a.sessionNo.compareTo(b.sessionNo));
    final minX = sorted.first.sessionNo.toDouble();
    final rawMaxX = sorted.last.sessionNo.toDouble();
    final maxX = rawMaxX == minX ? minX + 1 : rawMaxX;

    final spots = sorted
        .map((e) => FlSpot(e.sessionNo.toDouble(), e.score.toDouble()))
        .toList();

    return LineChartData(
      minX: minX,
      maxX: maxX,
      minY: 0,
      maxY: 100,
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: color,
          barWidth: 3,
          dotData: const FlDotData(show: true),
        ),
        if (targetScore != null)
          LineChartBarData(
            spots: [
              FlSpot(minX, targetScore.toDouble()),
              FlSpot(maxX, targetScore.toDouble()),
            ],
            isCurved: false,
            color: Brand.tertiary,
            barWidth: 2,
            dashArray: const [6, 4],
            dotData: const FlDotData(show: false),
          ),
      ],
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 20,
            getTitlesWidget: (value, meta) => Text(
              value.toInt().toString(),
              style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: (value, meta) => Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'S${value.toInt()}',
                style:
                    theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _targetCard(ProgressSummary summary, EnrollmentDto enrollment) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;
    final minSessions = enrollment.minSessions ?? 0;
    final completed = summary.completedSessions;
    final progress =
        (completed / (minSessions < 1 ? 1 : minSessions)).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Target Belajar',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            _infoRow(
              theme,
              'Target Nilai',
              summary.targetScore?.toString() ?? '-',
            ),
            const SizedBox(height: 8),
            _infoRow(theme, 'Rata-rata', summary.average.toStringAsFixed(1)),
            const SizedBox(height: 20),
            AnimatedProgressBar(value: progress, color: accent.c500),
            const SizedBox(height: 8),
            Text(
              '$completed/$minSessions Sesi Selesai',
              style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData theme, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
        ),
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _certificateCard(EnrollmentDto enrollment) {
    final theme = Theme.of(context);
    final target = enrollment.targetScore ?? 0;
    final eligible = enrollment.hasCertificate ||
        (enrollment.minSessions != null &&
            enrollment.completedSessions >= enrollment.minSessions! &&
            enrollment.averageScore >= target);

    if (eligible) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Brand.tertiary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Radii.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Brand.tertiary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Target Tercapai! Sertifikatmu siap diunduh.',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Unduh Sertifikat (PDF)',
              onPressed: () => _downloadCertificate(enrollment),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.lock, color: Brand.neutral, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sertifikat Belajar (Terkunci)',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selesaikan minimal ${enrollment.minSessions ?? 0} sesi dengan rata-rata ≥ $target',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Brand.neutral,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notesSection(List<ProgressEntryDto> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final sorted = [...entries]
      ..sort((a, b) => b.sessionNo.compareTo(a.sessionNo));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catatan dari Tentor',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in sorted) ...[
          _noteCard(entry),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _noteCard(ProgressEntryDto entry) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Sesi ${entry.sessionNo}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatDate(entry.date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Brand.neutral,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: accent.c100,
                    borderRadius: BorderRadius.circular(Radii.full),
                  ),
                  child: Text(
                    '${entry.score}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: accent.c600,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.note,
              style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressSkeleton() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: const [
        SkeletonLoader(width: 220, height: 48),
        SizedBox(height: 20),
        SkeletonLoader(width: double.infinity, height: 260),
        SizedBox(height: 16),
        SkeletonLoader(width: double.infinity, height: 180),
        SizedBox(height: 16),
        SkeletonLoader(width: double.infinity, height: 120),
      ],
    );
  }

  Widget _historyTab() {
    final historyAsync = ref.watch(bookingHistoryProvider);

    return historyAsync.when(
      data: (data) {
        final status = _statusFor(_filter);
        final bookings = status == null
            ? data.items
            : data.items.where((b) => b.status == status).toList();

        return Column(
          children: [
            _filterChips(),
            const SizedBox(height: 8),
            Expanded(
              child: bookings.isEmpty
                  ? const EmptyState(message: 'Belum ada riwayat booking')
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      itemCount: bookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          _bookingCard(bookings[index]),
                    ),
            ),
          ],
        );
      },
      loading: () => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: const [
          SkeletonLoader(width: double.infinity, height: 140),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 140),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 140),
        ],
      ),
      error: (_, _) => ErrorState(
        message: 'Gagal memuat riwayat booking',
        onRetry: () => ref.invalidate(bookingHistoryProvider),
      ),
    );
  }

  Widget _filterChips() {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _filter;
          return ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (_) => setState(() => _filter = filter),
            selectedColor: accent.c100,
            backgroundColor: theme.cardTheme.color,
            labelStyle: TextStyle(
              color: isSelected ? accent.c600 : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.full),
              side: BorderSide(
                color: isSelected ? accent.c600 : Colors.transparent,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bookingCard(BookingDto booking) {
    final theme = Theme.of(context);
    final subject = booking.subjectName ?? 'Sesi Les';
    final tutorName = booking.tutor?.name;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.lg),
        onTap: () => context.push('/bookings/${booking.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subject,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  StatusBadge(status: booking.status),
                ],
              ),
              if (tutorName != null) ...[
                const SizedBox(height: 6),
                Text(
                  tutorName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Brand.neutral,
                  ),
                ),
              ],
              const SizedBox(height: 6),
              Text(
                _formatDateTime(booking.slot.startsAt),
                style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
              ),
              if (booking.status == 'COMPLETED') ...[
                const SizedBox(height: 12),
                AppButton(
                  label: 'Nilai Tentor',
                  variant: AppButtonVariant.secondary,
                  onPressed: () =>
                      _showSnack('Fitur penilaian tentor segera hadir.'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return DateFormat('d MMM yyyy', 'id_ID').format(parsed.toLocal());
  }

  String _formatDateTime(String value) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return DateFormat('d MMM yyyy · HH:mm', 'id_ID').format(parsed.toLocal());
  }

  Future<void> _downloadCertificate(EnrollmentDto enrollment) async {
    final certificateId = enrollment.certificateId;
    if (certificateId == null) {
      _showSnack('Sertifikat belum tersedia untuk diunduh.');
      return;
    }

    try {
      await saveAndOpenCertificate(
        dio: ref.read(dioProvider),
        certificateId: certificateId,
      );
      _showSnack('Sertifikat berhasil diunduh.');
    } catch (_) {
      _showSnack('Gagal mengunduh sertifikat.');
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}