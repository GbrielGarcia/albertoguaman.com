import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
    this.mobileLarge,
  });

  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return mobile;
    if (context.isMobileLarge) return mobileLarge ?? mobile;
    if (context.isTablet) return tablet ?? mobileLarge ?? mobile;
    return desktop;
  }
}

enum Breakpoint {
  mobile,
  mobileLarge,
  tablet,
  desktop;
}

/// Valores de Breakpoint separados para ser usados como constantes
class BreakpointValues {
  static const double mobile = 400;
  static const double mobileLarge = 700;
  static const double tablet = 1024;
  static const double desktop = 1024;
}

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isMobile => screenWidth <= BreakpointValues.mobile; // Usa BreakpointValues
  bool get isMobileLarge => screenWidth <= BreakpointValues.mobileLarge; // Usa BreakpointValues
  bool get isTablet => screenWidth < BreakpointValues.tablet; // Usa BreakpointValues
  bool get isDesktop => screenWidth >= BreakpointValues.desktop; // Usa BreakpointValues
}
