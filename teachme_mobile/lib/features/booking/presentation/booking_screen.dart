import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/network/api_error.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/booking_stepper.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/core/widgets/status_badge.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';
import 'package:teachme_mobile/features/payment/presentation/payment_sheet.dart';
import 'package:teachme_mobile/features/review/presentation/review_sheet.dart';

final bookingProvider = FutureProvider.family<BookingDto, String>(
  (ref, id) => ref.watch(bookingApiProvider).getBooking(id),
);

class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) {
        ref.invalidate(bookingProvider(widget.bookingId));
      }
    });
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _cancel() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(bookingApiProvider).cancelBooking(widget.bookingId);
      ref.invalidate(bookingProvider(widget.bookingId));
      messenger.showSnackBar(const SnackBar(content: Text('Booking dibatalkan')));
    } catch (e) {
      String message = 'Gagal membatalkan booking. Coba lagi ya.';
      if (e is DioException && e.error is ApiError) {
        message = (e.error as ApiError).displayMessage;
      }
      messenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> _pay(BookingDto booking) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(bookingApiProvider).initiatePayment(booking.id);
      if (!mounted) return;
      await PaymentSheet.show(
        context,
        booking,
        onSuccess: () => ref.invalidate(bookingProvider(widget.bookingId)),
      );
    } catch (e) {
      String message = 'Gagal memulai pembayaran. Coba lagi ya.';
      if (e is DioException && e.error is ApiError) {
        message = (e.error as ApiError).displayMessage;
      }
      messenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _showReviewSheet(BuildContext context, String id) {
    ReviewSheet.show(
      context,
      bookingId: id,
      onSubmitted: () => ref.invalidate(bookingProvider(widget.bookingId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(bookingProvider(widget.bookingId));

    return async.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Detail Booking')),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SkeletonLoader(width: 120, height: 32)),
              SizedBox(height: 24),
              SkeletonLoader(width: double.infinity, height: 48),
              SizedBox(height: 24),
              SkeletonLoader(width: double.infinity, height: 220),
            ],
          ),
        ),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(title: const Text('Detail Booking')),
        body: ErrorState(
          message: 'Gagal memuat booking',
          onRetry: () => ref.invalidate(bookingProvider(widget.bookingId)),
        ),
      ),
      data: (booking) => Scaffold(
        appBar: AppBar(title: const Text('Detail Booking')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(child: StatusBadge(status: booking.status)),
            const SizedBox(height: 20),
            BookingStepper(currentStatus: booking.status),
            const SizedBox(height: 24),
            _summaryCard(context, booking),
            const SizedBox(height: 24),
            ..._statusSection(context, booking),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context, BookingDto booking) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    final start = DateTime.parse(booking.slot.startsAt).toLocal();
    final end = DateTime.parse(booking.slot.endsAt).toLocal();
    final dateLabel = DateFormat('EEEE, d MMM yyyy, HH:mm', 'id_ID').format(start);
    final endLabel = DateFormat('HH:mm', 'id_ID').format(end);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking.subjectName ?? 'Mata Pelajaran',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: accent.c600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  booking.tutor?.name ?? 'Tentor',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 18,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$dateLabel - $endLabel',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          if (booking.note != null && booking.note!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              '"${booking.note!}"',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const Divider(height: 32),
          _priceRow(theme, 'Biaya Sesi', currency.format(booking.priceIdr)),
          const SizedBox(height: 8),
          _priceRow(theme, 'Biaya Layanan', currency.format(booking.feeIdr)),
          const SizedBox(height: 12),
          _priceRow(
            theme,
            'Total',
            currency.format(booking.priceIdr + booking.feeIdr),
            bold: true,
            valueColor: accent.c600,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    ThemeData theme,
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) {
    final weight = bold ? FontWeight.bold : FontWeight.w400;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: weight),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: weight,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  List<Widget> _statusSection(BuildContext context, BookingDto booking) {
    switch (booking.status) {
      case 'PENDING':
        return [
          _banner(
            context,
            bg: StatusColors.warningBg,
            fg: StatusColors.warningText,
            icon: Icons.hourglass_empty,
            text: 'Menunggu konfirmasi tentor. Tentor akan merespon dalam 24 jam.',
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Batalkan Booking',
            variant: AppButtonVariant.outlined,
            onPressed: _cancel,
          ),
        ];
      case 'ACCEPTED':
        return [
          _banner(
            context,
            bg: StatusColors.infoBg,
            fg: StatusColors.infoLight,
            icon: Icons.info_outline,
            text: 'Yay! Tentor menyetujui jadwalmu. Segera selesaikan pembayaran.',
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Bayar Sekarang',
            variant: AppButtonVariant.primary,
            onPressed: () => _pay(booking),
          ),
        ];
      case 'PAID':
        return [
          _banner(
            context,
            bg: StatusColors.paidBg,
            fg: StatusColors.paidLight,
            icon: Icons.check_circle,
            text: 'Pembayaran Berhasil! Sampai ketemu di sesi les',
          ),
        ];
      case 'COMPLETED':
        return [
          _banner(
            context,
            bg: StatusColors.successLight.withValues(alpha: 0.12),
            fg: StatusColors.successLight,
            icon: Icons.celebration,
            text: 'Sesi les telah selesai!',
          ),
          if (booking.note != null && booking.note!.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Catatan Tentor: ${booking.note!}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 16),
          AppButton(
            label: 'Beri Ulasan Tentor',
            variant: AppButtonVariant.secondary,
            onPressed: () => _showReviewSheet(context, booking.id),
          ),
        ];
      case 'REJECTED':
        return [
          _banner(
            context,
            bg: StatusColors.errorLight.withValues(alpha: 0.12),
            fg: StatusColors.errorLight,
            icon: Icons.cancel_outlined,
            text: booking.rejectReason ?? 'Booking ditolak oleh tentor.',
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Cari Jadwal Lain',
            variant: AppButtonVariant.primary,
            onPressed: () => context.go('/home'),
          ),
        ];
      case 'CANCELLED':
      case 'EXPIRED':
      default:
        return [
          _banner(
            context,
            bg: Theme.of(context).colorScheme.surfaceContainerHighest,
            fg: Brand.neutral,
            icon: Icons.block,
            text: booking.rejectReason ?? 'Booking tidak aktif lagi.',
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Cari Jadwal Lain',
            variant: AppButtonVariant.primary,
            onPressed: () => context.go('/home'),
          ),
        ];
    }
  }

  Widget _banner(
    BuildContext context, {
    required Color bg,
    required Color fg,
    required IconData icon,
    required String text,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: fg),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}