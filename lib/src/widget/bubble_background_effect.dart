import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'animated_background.dart';
import 'year_float_background.dart';

/// Preferencia global: mostrar u ocultar el fondo de partículas (burbujas).
/// Por defecto está desactivado; si el usuario lo activa, se persiste con [SharedPreferences] (en web, `localStorage`).
class BubbleBackgroundProvider extends ChangeNotifier {
  BubbleBackgroundProvider() {
    unawaited(_loadPersisted());
  }

  static const _prefsKey = 'bubble_background_particles_enabled';

  bool _enabled = false;

  bool get bubblesEnabled => _enabled;

  Future<void> _loadPersisted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getBool(_prefsKey);
      if (stored != null && stored != _enabled) {
        _enabled = stored;
        notifyListeners();
      }
    } catch (_) {
      // Sin almacenamiento disponible: se mantiene el valor por defecto.
    }
  }

  Future<void> setBubblesEnabled(bool value) async {
    if (_enabled == value) return;
    _enabled = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, value);
    } catch (_) {
      // Si falla el guardado, el estado en memoria sigue aplicando en la sesión.
    }
  }
}

/// Aplica [animatedBackground] al fondo solo si la preferencia está activa.
///
/// Las partículas van en una capa separada (no envuelven el contenido) para
/// evitar remounts del árbol al alternar, y se usa [TickerProviderStateMixin]
/// porque [AnimatedBackground] crea el ticker en `attach` y lo libera en
/// `detach` (puede ocurrir varias veces al pulsar el switch rápido).
class BubbleBackgroundLayer extends StatefulWidget {
  const BubbleBackgroundLayer({
    super.key,
    required this.child,
    this.particleCount = 110,
  });

  final Widget child;
  final int particleCount;

  @override
  State<BubbleBackgroundLayer> createState() => _BubbleBackgroundLayerState();
}

class _BubbleBackgroundLayerState extends State<BubbleBackgroundLayer>
    with TickerProviderStateMixin {
  final List<_BinaryTrailParticle> _binaryTrail = [];
  late final AnimationController _binaryTrailTicker;
  Offset? _lastPointerPosition;
  DateTime? _lastParticleAt;
  int _binaryDigit = 0;

  @override
  void initState() {
    super.initState();
    _binaryTrailTicker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_updateBinaryTrail);
  }

  void _onPointerHover(PointerHoverEvent event) {
    final now = DateTime.now();
    final movedEnough = _lastPointerPosition == null ||
        (event.localPosition - _lastPointerPosition!).distance >= 24;
    final waitedEnough = _lastParticleAt == null ||
        now.difference(_lastParticleAt!).inMilliseconds >= 60;
    if (!movedEnough && !waitedEnough) return;

    _lastPointerPosition = event.localPosition;
    _lastParticleAt = now;
    _binaryTrail.add(
      _BinaryTrailParticle(
        position: event.localPosition,
        digit: (_binaryDigit++ % 2).toString(),
        createdAt: now,
        colorIndex: _binaryDigit % 3,
      ),
    );
    if (_binaryTrail.length > 42) _binaryTrail.removeAt(0);
    if (!_binaryTrailTicker.isAnimating) {
      _binaryTrailTicker.repeat();
    }
    setState(() {});
  }

  void _updateBinaryTrail() {
    if (!mounted) return;
    final now = DateTime.now();
    _binaryTrail.removeWhere(
      (particle) => now.difference(particle.createdAt).inMilliseconds > 1050,
    );
    if (_binaryTrail.isEmpty) {
      _binaryTrailTicker.stop();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _binaryTrailTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleBackgroundProvider>(
      builder: (context, prefs, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const Positioned.fill(
              child: YearFloatBackground(),
            ),
            if (prefs.bubblesEnabled)
              Positioned.fill(
                child: IgnorePointer(
                  child: animatedBackground(
                    const SizedBox.expand(),
                    this,
                    particleCount: widget.particleCount,
                  ),
                ),
              ),
            MouseRegion(
              opaque: false,
              onHover: _onPointerHover,
              child: child!,
            ),
            if (_binaryTrail.isNotEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _BinaryTrailPainter(
                      particles: List.unmodifiable(_binaryTrail),
                      now: DateTime.now(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _BinaryTrailParticle {
  const _BinaryTrailParticle({
    required this.position,
    required this.digit,
    required this.createdAt,
    required this.colorIndex,
  });

  final Offset position;
  final String digit;
  final DateTime createdAt;
  final int colorIndex;
}

class _BinaryTrailPainter extends CustomPainter {
  const _BinaryTrailPainter({
    required this.particles,
    required this.now,
  });

  final List<_BinaryTrailParticle> particles;
  final DateTime now;

  static final _colors = [
    UtilsColor.colorYellow,
    UtilsColor.colorPink,
    UtilsColor.colorBlue,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final age = now.difference(particle.createdAt).inMilliseconds;
      final progress = (age / 1050).clamp(0.0, 1.0);
      final opacity = (1 - progress).clamp(0.0, 1.0);
      final driftX = (particle.colorIndex - 1) * progress * 10;
      final position = particle.position + Offset(driftX, -22 * progress);
      final painter = TextPainter(
        text: TextSpan(
          text: particle.digit,
          style: TextStyle(
            color: _colors[particle.colorIndex].withValues(alpha: opacity),
            fontFamily: 'Minecraftia',
            fontSize: 13 + (1 - progress) * 5,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: _colors[particle.colorIndex]
                    .withValues(alpha: opacity * 0.65),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(covariant _BinaryTrailPainter oldDelegate) => true;
}

/// Interruptor en la esquina inferior izquierda (opuesta al FAB de WhatsApp a la derecha).
class BubbleBackgroundToggleOverlay extends StatelessWidget {
  const BubbleBackgroundToggleOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<BubbleBackgroundProvider>();

    return Positioned(
      left: 0,
      bottom: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Material(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    prefs.bubblesEnabled ? Icons.blur_on : Icons.blur_off,
                    size: 20,
                    color:
                        UtilsColor.colorSecondaryWhite.withValues(alpha: 0.85),
                  ),
                  Tooltip(
                    message: prefs.bubblesEnabled
                        ? 'Desactivar fondo animado'
                        : 'Activar fondo animado',
                    child: Switch.adaptive(
                      value: prefs.bubblesEnabled,
                      activeThumbColor: UtilsColor.colorYellow,
                      activeTrackColor:
                          UtilsColor.colorYellow.withValues(alpha: 0.45),
                      inactiveThumbColor: Colors.white54,
                      inactiveTrackColor: Colors.white24,
                      onChanged: (v) => unawaited(prefs.setBubblesEnabled(v)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
