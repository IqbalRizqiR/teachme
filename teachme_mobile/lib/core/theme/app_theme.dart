import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

ThemeData buildTheme(Brightness brightness, {AppRole? role}) {
  final dark = brightness == Brightness.dark;

  final accent = switch (role) {
    AppRole.student => RoleAccent.student,
    AppRole.tutor => RoleAccent.tutor,
    null => RoleAccent.brand,
  };

  final bg = dark ? const Color(0xFF141218) : const Color(0xFFFDF9FF);
  final surface = dark ? const Color(0xFF211F26) : const Color(0xFFF1ECF4);
  // final surfaceRaised = dark ? const Color(0xFF2B2930) : const Color(0xFFFFFFFF);
  final outline = dark ? const Color(0xFF48464C) : const Color(0xFFCAC5CC);
  final text = dark ? const Color(0xFFE6E1E9) : const Color(0xFF1C1B1F);
  // final textSecondary = dark ? const Color(0xFFCAC5CC) : const Color(0xFF48464C);

  final colorScheme = ColorScheme(
    brightness: brightness,
    primary: accent.c600,
    onPrimary: Colors.white,
    secondary: Brand.secondary,
    onSecondary: Colors.white,
    tertiary: Brand.tertiary,
    onTertiary: Colors.white,
    error: dark ? StatusColors.errorDark : StatusColors.errorLight,
    onError: Colors.white,
    surface: bg,
    onSurface: text,
    outline: outline,
  );

  final textTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(fontSize: 40, height: 48 / 40, fontWeight: FontWeight.w800),
    headlineLarge: GoogleFonts.montserrat(fontSize: 32, height: 40 / 32, fontWeight: FontWeight.w700),
    headlineMedium: GoogleFonts.montserrat(fontSize: 24, height: 32 / 24, fontWeight: FontWeight.w700),
    headlineSmall: GoogleFonts.montserrat(fontSize: 20, height: 28 / 20, fontWeight: FontWeight.w600),
    bodyLarge: GoogleFonts.beVietnamPro(fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.beVietnamPro(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.beVietnamPro(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600),
    labelSmall: GoogleFonts.beVietnamPro(fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500),
  ).apply(bodyColor: text, displayColor: text);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: bg,
    textTheme: textTheme,
    extensions: [accent],
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
        textStyle: GoogleFonts.beVietnamPro(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(64, 48),
        side: BorderSide(color: outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.sm),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.sm),
        borderSide: BorderSide(color: accent.c600, width: 2),
      ),
    ),
  );
}
