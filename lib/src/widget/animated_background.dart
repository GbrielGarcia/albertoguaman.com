
  import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

Widget animatedBackground(Widget child, TickerProvider vsync,
      {int? particleCount}) {
    return AnimatedBackground(
      vsync: vsync,
      behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
        // Tono cian suave para un look más elegante sobre fondo oscuro.
        baseColor: const Color(0xFF9FE9FF),
        opacityChangeRate: 0.18,
        particleCount: particleCount ?? 200,
        minOpacity: 0.08,
        maxOpacity: 0.65,
        spawnOpacity: 0.22,
        spawnMaxRadius: 7.0,
        spawnMinRadius: 1.6,
        spawnMaxSpeed: 95.0,
        spawnMinSpeed: 25.0,
      )),
      child: child,
    );
  }