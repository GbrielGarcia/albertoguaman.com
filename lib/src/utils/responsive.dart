import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
    this.mobileLarge,
    this.tabletLarge,
  });

  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget? tabletLarge;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return mobile;
    if (context.isMobileLarge) return mobileLarge ?? mobile;
    if (context.isTabletLarge) return tabletLarge ?? tablet ?? mobileLarge ?? mobile;
    if (context.isTablet) return tablet ?? mobileLarge ?? mobile;
    return desktop;
  }
}

enum Breakpoint {
  mobile,
  mobileLarge,
  tablet,
  tabletLarge,
  desktop;
}

/// Valores de Breakpoint separados para ser usados como constantes
class BreakpointValues {
  static const double mobile = 400;
  static const double mobileLarge = 600;
  static const double tablet = 800;
  static const double tabletLarge = 1200;
  static const double desktop = 1200;
}

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isMobile => screenWidth <= BreakpointValues.mobile; // Móvil
  bool get isMobileLarge => screenWidth <= BreakpointValues.mobileLarge; // Móvil grande
  bool get isTablet => screenWidth > BreakpointValues.mobileLarge && screenWidth < BreakpointValues.tablet; // Tablet
  bool get isTabletLarge => screenWidth >= BreakpointValues.tablet && screenWidth < BreakpointValues.desktop; // Tablet grande
  bool get isDesktop => screenWidth >= BreakpointValues.desktop; // Escritorio
}
