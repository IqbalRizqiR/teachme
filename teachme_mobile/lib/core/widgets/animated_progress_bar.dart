import 'package:flutter/material.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 8,
  });

  final double value;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>()!;
    final trackColor = theme.colorScheme.surfaceContainerHighest;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, animated, _) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(Radii.full),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: animated,
              child: Container(
                decoration: BoxDecoration(
                  color: color ?? accent.c500,
                  borderRadius: BorderRadius.circular(Radii.full),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
