import 'package:flutter/material.dart';

enum AppRole { student, tutor }

abstract final class Brand {
  static const primary = Color(0xFF8069BF);
  static const primaryDeep = Color(0xFF4A3585);
  static const secondary = Color(0xFF7C7296);
  static const tertiary = Color(0xFFC9A74D);
  static const neutral = Color(0xFF79767D);
}

abstract final class Radii {
  static const double sm = 12, md = 16, lg = 20, full = 999;
}

abstract final class StatusColors {
  static const successLight = Color(0xFF1E8E5A);
  static const successDark = Color(0xFF5FD3A0);
  static const warningBg = Color(0xFFFFefc4);
  static const warningText = Color(0xFF8F7425);
  static const errorLight = Color(0xFFB3261E);
  static const errorDark = Color(0xFFFFB4AB);
  static const infoLight = Color(0xFF6A53A8);
  static const infoBg = Color(0xFFE7DEFF);
  static const paidLight = Color(0xFF0A8073);
  static const paidBg = Color(0xFFCCF4EE);
}

@immutable
class RoleAccent extends ThemeExtension<RoleAccent> {
  const RoleAccent({required this.c500, required this.c600, required this.c100});
  final Color c500;
  final Color c600;
  final Color c100;

  static const brand = RoleAccent(c500: Brand.primary, c600: Brand.primaryDeep, c100: Color(0xFFE7DEFF));
  static const student = RoleAccent(c500: Color(0xFFFF6B57), c600: Color(0xFFCF3E2A), c100: Color(0xFFFFE3DE));
  static const tutor = RoleAccent(c500: Color(0xFF14B8A6), c600: Color(0xFF0A8073), c100: Color(0xFFCCF4EE));

  @override
  RoleAccent copyWith({Color? c500, Color? c600, Color? c100}) =>
      RoleAccent(c500: c500 ?? this.c500, c600: c600 ?? this.c600, c100: c100 ?? this.c100);

  @override
  RoleAccent lerp(ThemeExtension<RoleAccent>? other, double t) {
    if (other is! RoleAccent) return this;
    return RoleAccent(
      c500: Color.lerp(c500, other.c500, t)!,
      c600: Color.lerp(c600, other.c600, t)!,
      c100: Color.lerp(c100, other.c100, t)!,
    );
  }
}
