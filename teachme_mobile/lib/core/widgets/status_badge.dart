import 'package:flutter/material.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final (icon, label, bg, fg) = switch (status) {
      'PENDING' => (Icons.hourglass_empty, 'Menunggu', StatusColors.warningBg, StatusColors.warningText),
      'ACCEPTED' => (Icons.check_circle_outline, 'Diterima', StatusColors.infoBg, StatusColors.infoLight),
      'PAID' => (Icons.credit_card, 'Dibayar', StatusColors.paidBg, StatusColors.paidLight),
      'COMPLETED' => (Icons.celebration, 'Selesai', const Color(0xFFD4EDDA), StatusColors.successLight),
      'REJECTED' => (Icons.cancel_outlined, 'Ditolak', const Color(0xFFFCE4E4), StatusColors.errorLight),
      'CANCELLED' => (Icons.block, 'Dibatalkan', const Color(0xFFE6E1E9), const Color(0xFF79767D)),
      'EXPIRED' => (Icons.timer_off, 'Kadaluarsa', const Color(0xFFE6E1E9), const Color(0xFF79767D)),
      _ => (Icons.help_outline, status, const Color(0xFFE6E1E9), const Color(0xFF79767D)),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}
