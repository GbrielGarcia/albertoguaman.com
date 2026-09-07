import 'package:flutter/material.dart';

/// Avatar recortado con silueta de sticker, sin marco circular.
class AvatarSticker extends StatelessWidget {
  const AvatarSticker({
    super.key,
    this.size = 190,
    this.assetPath = 'assets/img/avatar/alberto_sticker.png',
  });

  final double size;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.025,
      child: SizedBox(
        width: size,
        height: size * 1.08,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          errorBuilder: (_, __, ___) => Icon(
            Icons.person,
            size: size * 0.7,
          ),
        ),
      ),
    );
  }
}
