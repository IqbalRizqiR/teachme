import 'package:flutter/material.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';

class BookingStepper extends StatelessWidget {
  const BookingStepper({super.key, required this.currentStatus});

  final String currentStatus;

  static const _steps = ['PENDING', 'ACCEPTED', 'PAID', 'COMPLETED'];
  static const _labels = ['Pending', 'Accepted', 'Paid', 'Completed'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>()!;
    final outline = theme.colorScheme.outline;
    final activeIndex = _steps.indexOf(currentStatus);

    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final stepBefore = i ~/ 2;
          final completed = stepBefore < activeIndex;
          return Expanded(
            child: Container(
              height: 2,
              color: completed ? accent.c500 : outline,
            ),
          );
        }

        final stepIndex = i ~/ 2;
        final isActive = stepIndex <= activeIndex;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? accent.c500 : null,
                border: isActive ? null : Border.all(color: outline, width: 2),
              ),
              child: isActive
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 4),
            Text(
              _labels[stepIndex],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isActive ? accent.c600 : outline,
              ),
            ),
          ],
        );
      }),
    );
  }
}
