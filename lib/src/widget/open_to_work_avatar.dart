import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/avatar_sticker.dart';
import 'package:flutter/material.dart';

/// Avatar con anillo luminoso verde = abierto a oportunidades.
class OpenToWorkAvatar extends StatelessWidget {
  const OpenToWorkAvatar({
    super.key,
    this.size = 220,
    this.showLabel = true,
  });

  final double size;
  final bool showLabel;

  static const _glow = Color(0xFF3DDC97);

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final ring = size + 28;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _glow,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _glow.withValues(alpha: 0.7),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: SizeUtils.s / 2),
              Flexible(
                child: Text(
                  al.availabilityOpen,
                  textAlign: TextAlign.center,
                  style: StyleText.textPortfolio(
                    fontSize: bodySize * 0.85,
                    fontWeight: FontWeight.w700,
                    color: _glow,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.m),
        ],
        SizedBox(
          width: ring,
          height: ring,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Halo exterior
              Container(
                width: ring,
                height: ring,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _glow.withValues(alpha: 0.35),
                      blurRadius: 28,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: _glow.withValues(alpha: 0.18),
                      blurRadius: 48,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),
              // Anillo
              Container(
                width: ring - 6,
                height: ring - 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _glow.withValues(alpha: 0.85),
                    width: 3,
                  ),
                  gradient: SweepGradient(
                    colors: [
                      _glow.withValues(alpha: 0.15),
                      _glow.withValues(alpha: 0.45),
                      _glow.withValues(alpha: 0.15),
                    ],
                  ),
                ),
              ),
              // Foto de perfil en círculo
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: UtilsColor.colorSurface,
                  border: Border.all(
                    color: _glow.withValues(alpha: 0.55),
                    width: 2,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: AvatarSticker(size: size),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
