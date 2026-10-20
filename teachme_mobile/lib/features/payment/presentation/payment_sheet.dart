import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';

class PaymentSheet extends ConsumerStatefulWidget {
  const PaymentSheet({
    super.key,
    required this.booking,
    required this.onPaymentSuccess,
  });

  final BookingDto booking;
  final VoidCallback onPaymentSuccess;

  static Future<void> show(
    BuildContext context,
    BookingDto booking, {
    required VoidCallback onSuccess,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => PaymentSheet(booking: booking, onPaymentSuccess: onSuccess),
    );
  }

  @override
  ConsumerState<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends ConsumerState<PaymentSheet> {
  String _selectedMethod = 'QRIS';
  bool _loading = false;

  static const _methods = [
    ('QRIS', 'QRIS Instant', Icons.qr_code_scanner),
    ('BCA_VA', 'BCA Virtual Account', Icons.account_balance),
    ('GOPAY', 'GoPay / E-Wallet', Icons.account_balance_wallet),
  ];

  Future<void> _pay() async {
    final orderId = widget.booking.payment?.orderId ?? 'TM-${widget.booking.id}';
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    setState(() => _loading = true);
    try {
      await ref.read(bookingApiProvider).settlePayment(orderId);
      if (!mounted) return;
      navigator.pop();
      widget.onPaymentSuccess();
      messenger.showSnackBar(
        const SnackBar(content: Text('Pembayaran berhasil! Sesi les kamu sudah aman 🎉')),
      );
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Pembayaran gagal. Coba lagi ya.')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Metode Pembayaran',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Tagihan',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currency.format(widget.booking.priceIdr),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accent.c600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._methods.map(
            (m) => _methodTile(
              theme: theme,
              accent: accent,
              id: m.$1,
              label: m.$2,
              icon: m.$3,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Simulasi Pembayaran (dev)',
              variant: AppButtonVariant.primary,
              isLoading: _loading,
              onPressed: _pay,
            ),
          ),
        ],
      ),
    );
  }

  Widget _methodTile({
    required ThemeData theme,
    required RoleAccent accent,
    required String id,
    required String label,
    required IconData icon,
  }) {
    final selected = _selectedMethod == id;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.md),
        onTap: () => setState(() => _selectedMethod = id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.md),
            border: Border.all(
              color: selected ? accent.c600 : theme.dividerColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? accent.c600 : theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? accent.c600 : theme.colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}