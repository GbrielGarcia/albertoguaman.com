import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'animated_background.dart';

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

/// Aplica [animatedBackground] al [child] solo si la preferencia está activa.
/// Mantiene un [SingleTickerProviderStateMixin] local para no forzar mixins en cada pantalla.
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
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleBackgroundProvider>(
      builder: (context, prefs, _) {
        if (!prefs.bubblesEnabled) return widget.child;
        return animatedBackground(
          widget.child,
          this,
          particleCount: widget.particleCount,
        );
      },
    );
  }
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
                    color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.85),
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
