import 'package:flutter/material.dart';

/// Fade + leve slide al hacerse visible en scroll.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.child,
    this.controller,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 520),
    this.offsetY = 18,
    this.visibilityFraction = 0.88,
  });

  final Widget child;
  final ScrollController? controller;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  /// Fracción de altura de pantalla: se revela cuando el top del widget está por encima.
  final double visibilityFraction;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _t = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    widget.controller?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didUpdateWidget(covariant ScrollReveal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_check);
      widget.controller?.addListener(_check);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_check);
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (!mounted || _started) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;
    if (top < screenH * widget.visibilityFraction) {
      _started = true;
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (context, child) {
        final v = _t.value;
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, widget.offsetY * (1 - v)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Entrada en secuencia al montar (hero).
class StaggerFadeIn extends StatefulWidget {
  const StaggerFadeIn({
    super.key,
    required this.child,
    this.index = 0,
    this.step = const Duration(milliseconds: 90),
    this.duration = const Duration(milliseconds: 480),
    this.offsetY = 12,
  });

  final Widget child;
  final int index;
  final Duration step;
  final Duration duration;
  final double offsetY;

  @override
  State<StaggerFadeIn> createState() => _StaggerFadeInState();
}

class _StaggerFadeInState extends State<StaggerFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _t = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    Future<void>.delayed(widget.step * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (context, child) {
        final v = _t.value;
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, widget.offsetY * (1 - v)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Escala suave al pasar el mouse (desktop).
class HoverScale extends StatefulWidget {
  const HoverScale({
    super.key,
    required this.child,
    this.scale = 1.02,
    this.duration = const Duration(milliseconds: 180),
  });

  final Widget child;
  final double scale;
  final Duration duration;

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? widget.scale : 1,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
