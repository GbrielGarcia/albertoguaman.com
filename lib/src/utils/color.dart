import 'package:flutter/material.dart';

/// Paleta clásica del sitio (antes del rediseño slate/azul cielo).
class UtilsColor {
  /// Alterna paleta clara/oscura (lo controla ThemeModeProvider).
  static bool useLight = false;

  static Color get colorBg =>
      useLight ? const Color(0xFFECE9E2) : const Color(0xFF151515);

  static Color get colorSurface =>
      useLight ? const Color(0xFFFFFFFF) : const Color(0xFF1C1C1C);

  static Color get colorElevated =>
      useLight ? const Color(0xFFF7F4EE) : const Color(0xFF242424);

  static Color get colorPrimaryDark => colorBg;

  static Color get colorSecondaryWhite =>
      useLight ? const Color(0xFF151515) : const Color(0xFFFFFFFF);

  /// Azul violeta original.
  static Color get colorBlue => const Color(0xFF707EFF);

  static Color get colorYellow => const Color(0xFFFAD85D);

  static Color get colorPink => const Color(0xFFF2A0FF);
  static Color get colorPinkSecondary => const Color(0xFFFDADC6);

  static Color get colorMuted =>
      useLight ? const Color(0xFF5A5A5A) : const Color(0xFFB0B0B0);

  static Color get colorCream =>
      useLight ? const Color(0xFFECE9E2) : colorBg;
  static Color get colorCharcoal => colorBg;
  static Color get colorCardDark => colorSurface;

  static Color get hairline =>
      colorSecondaryWhite.withValues(alpha: useLight ? 0.14 : 0.12);

  static Color get accentSoft => colorBlue.withValues(alpha: 0.18);
}

const List<Color> tabColors = [
  Color(0xFFECE9E2),
  Color(0xFFDAD2F8),
  Color(0xFFF7D3D3),
];
