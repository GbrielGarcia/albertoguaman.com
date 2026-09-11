import 'dart:math' as math;

import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

/// Año actual del sistema (cambia solo al pasar de año).
String currentPortfolioYear() => DateTime.now().year.toString();

/// Fondo decorativo: año actual repetido en distintos tamaños y opacidades.
class YearFloatBackground extends StatelessWidget {
  const YearFloatBackground({
    super.key,
    this.year,
  });

  /// Si es null, usa [DateTime.now].year automáticamente.
  final String? year;

  static const _items = <_YearSpec>[
    _YearSpec(dx: 0.06, dy: 0.08, size: 120, opacity: 0.01, angle: -0.12),
    _YearSpec(dx: 0.55, dy: 0.04, size: 72, opacity: 0.014, angle: 0.18),
    _YearSpec(dx: 0.78, dy: 0.18, size: 160, opacity: 0.008, angle: -0.08),
    _YearSpec(dx: 0.12, dy: 0.32, size: 48, opacity: 0.016, angle: 0.22),
    _YearSpec(dx: 0.42, dy: 0.28, size: 96, opacity: 0.01, angle: -0.2),
    _YearSpec(dx: 0.68, dy: 0.42, size: 54, opacity: 0.013, angle: 0.1),
    _YearSpec(dx: 0.02, dy: 0.55, size: 140, opacity: 0.007, angle: 0.15),
    _YearSpec(dx: 0.35, dy: 0.58, size: 64, opacity: 0.012, angle: -0.28),
    _YearSpec(dx: 0.82, dy: 0.62, size: 88, opacity: 0.01, angle: 0.05),
    _YearSpec(dx: 0.18, dy: 0.78, size: 110, opacity: 0.009, angle: -0.05),
    _YearSpec(dx: 0.58, dy: 0.82, size: 46, opacity: 0.015, angle: 0.3),
    _YearSpec(dx: 0.88, dy: 0.88, size: 130, opacity: 0.008, angle: -0.15),
    _YearSpec(dx: 0.48, dy: 0.14, size: 38, opacity: 0.016, angle: 0.4),
    _YearSpec(dx: 0.28, dy: 0.45, size: 180, opacity: 0.007, angle: -0.04),
  ];

  @override
  Widget build(BuildContext context) {
    final label = year ?? currentPortfolioYear();
    final base = UtilsColor.useLight
        ? UtilsColor.colorBlue
        : UtilsColor.colorSecondaryWhite;

    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (final item in _items)
                Positioned(
                  left: item.dx * w,
                  top: item.dy * h,
                  child: Transform.rotate(
                    angle: item.angle,
                    child: Text(
                      label,
                      style: StyleText.textPortfolio(
                        fontSize: item.size,
                        fontWeight: FontWeight.w800,
                        color: base.withValues(alpha: item.opacity),
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _YearSpec {
  const _YearSpec({
    required this.dx,
    required this.dy,
    required this.size,
    required this.opacity,
    required this.angle,
  });

  final double dx;
  final double dy;
  final double size;
  final double opacity;
  final double angle;
}

/// Ligera deriva vertical para sensación flotante.
class YearFloatBackgroundAnimated extends StatefulWidget {
  const YearFloatBackgroundAnimated({
    super.key,
    this.year,
  });

  final String? year;

  @override
  State<YearFloatBackgroundAnimated> createState() =>
      _YearFloatBackgroundAnimatedState();
}

class _YearFloatBackgroundAnimatedState
    extends State<YearFloatBackgroundAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final dy = math.sin(t * math.pi * 2) * 10;
        return Transform.translate(
          offset: Offset(0, dy),
          child: child,
        );
      },
      child: YearFloatBackground(year: widget.year),
    );
  }
}
