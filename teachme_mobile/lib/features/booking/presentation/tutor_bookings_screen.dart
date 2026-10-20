import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/empty_state.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/core/widgets/status_badge.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

final tutorBookingsProvider = FutureProvider<PaginatedBookings>(
  (ref) => ref.watch(bookingApiProvider).listBookings(),
);

const _filterStatus = <String, String?>{
  'Semua': null,
  'Menunggu': 'PENDING',
  'Dibayar': 'PAID',
  'Selesai': 'COMPLETED',
  'Ditolak': 'REJECTED',
};

class TutorBookingsScreen extends ConsumerStatefulWidget {
  const TutorBookingsScreen({super.key});

  @override
  ConsumerState<TutorBookingsScreen> createState() =>
      _TutorBookingsScreenState();
}

class _TutorBookingsScreenState extends ConsumerState<TutorBookingsScreen> {
  String _filter = 'Semua';

  Future<void> _refresh() async {
    ref.invalidate(tutorBookingsProvider);
    await ref.read(tutorBookingsProvider.future);
  }

  Future<void> _accept(String id) async {
    try {
      await ref.read(bookingApiProvider).acceptBooking(id);
      ref.invalidate(tutorBookingsProvider);
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
      ref.invalidate(tutorBookingsProvider);
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

  bool _slotEnded(SlotDto slot) {
    final end = DateTime.tryParse(slot.endsAt)?.toLocal();
    if (end == null) return false;
    return end.isBefore(DateTime.now());
  }

  String _slotLabel(SlotDto slot) {
    final start = DateTime.tryParse(slot.startsAt)?.toLocal();
    final end = DateTime.tryParse(slot.endsAt)?.toLocal();
    if (start == null || end == null) return '${slot.startsAt} - ${slot.endsAt}';
    final date = DateFormat('d MMM yyyy, HH:mm', 'id_ID').format(start);
    final endTime = DateFormat('HH:mm').format(end);
    return '$date - $endTime';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;
    final status = _filterStatus[_filter];
    final asyncBookings = ref.watch(tutorBookingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Masuk')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                for (final entry in _filterStatus.entries) ...[
                  ChoiceChip(
                    label: Text(entry.key),
                    selected: _filter == entry.key,
                    selectedColor: accent.c100,
                    labelStyle: TextStyle(
                      color: _filter == entry.key
                          ? accent.c600
                          : theme.colorScheme.onSurface,
                    ),
                    onSelected: (_) => setState(() => _filter = entry.key),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: accent.c600,
              onRefresh: _refresh,
              child: asyncBookings.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: 4,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, __) => const SkeletonLoader(
                    width: double.infinity,
                    height: 140,
                    borderRadius: Radii.lg,
                  ),
                ),
                error: (error, _) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 100),
                    ErrorState(
                      message: 'Gagal memuat booking',
                      onRetry: () => ref.invalidate(tutorBookingsProvider),
                    ),
                  ],
                ),
                data: (data) {
                  final items = status == null
                      ? data.items
                      : data.items.where((b) => b.status == status).toList();
                  if (items.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      children: const [
                        SizedBox(height: 100),
                        EmptyState(message: 'Belum ada booking untuk filter ini.'),
                      ],
                    );
                  }
                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) =>
                        _bookingCard(items[index], theme),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingCard(BookingDto booking, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.student?.name ?? '-',
                        style: theme.textTheme.labelLarge,
                      ),
                      Text(
                        booking.subjectName ?? '-',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: booking.status),
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
                    _slotLabel(booking.slot),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            if (booking.status == 'PENDING') ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Tolak',
                      variant: AppButtonVariant.outlined,
                      onPressed: () => _reject(booking.id),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Terima',
                      variant: AppButtonVariant.primary,
                      onPressed: () => _accept(booking.id),
                    ),
                  ),
                ],
              ),
            ],
            if (booking.status == 'PAID' && _slotEnded(booking.slot)) ...[
              const SizedBox(height: 14),
              AppButton(
                label: 'Beri Nilai',
                variant: AppButtonVariant.primary,
                onPressed: () => context.push('/bookings/${booking.id}/grade'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}