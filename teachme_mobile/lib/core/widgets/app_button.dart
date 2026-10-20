import 'package:flutter/material.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';

enum AppButtonVariant { primary, secondary, outlined, inverted }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>()!;

    final child = isLoading
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(label);

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.md),
    );
    const minSize = Size(64, 48);

    return switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: accent.c600,
            minimumSize: minSize,
            shape: shape,
          ),
          child: child,
        ),
      AppButtonVariant.secondary => FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            minimumSize: minSize,
            shape: shape,
          ),
          child: child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: minSize,
            shape: shape,
          ),
          child: child,
        ),
      AppButtonVariant.inverted => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Brand.neutral,
            foregroundColor: Colors.white,
            minimumSize: minSize,
            shape: shape,
          ),
          child: child,
        ),
    };
  }
}
