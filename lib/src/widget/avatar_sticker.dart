import 'package:flutter/material.dart';

/// Foto de perfil (CV) usada en hero y secciones About.
class AvatarSticker extends StatelessWidget {
  const AvatarSticker({
    super.key,
    this.size = 190,
    this.assetPath = 'assets/cv/alberto_cv_photo.jpg',
  });

  final double size;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
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
