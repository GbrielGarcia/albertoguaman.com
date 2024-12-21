
  import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget animatedBackground(Widget child, TickerProvider vsync,
      {int? particleCount}) {
    return AnimatedBackground(
      vsync: vsync,
      behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
        baseColor: UtilsColor.colorSecondaryWhite,
        opacityChangeRate: 0.25,
        particleCount: particleCount ?? 200,
        minOpacity: 0.1,
        maxOpacity: 0.9,
        spawnOpacity: 0.3,
        spawnMaxRadius: 5.0,
        spawnMinRadius: 2.0,
        spawnMaxSpeed: 150.0,
        spawnMinSpeed: 50.0,
      )),
      child: child,
    );
  }