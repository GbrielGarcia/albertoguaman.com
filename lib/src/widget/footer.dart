import 'package:flutter/material.dart';
import 'package:albertoguaman/l10n/app_localizations.dart';

import '../utils/utils.dart';

Widget footerData(AppLocalizations? al, double screenWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: SizeUtils.l),
    child: Column(
      children: [
        Container(
          width: 48,
          height: 2,
          decoration: BoxDecoration(
            color: UtilsColor.colorBlue.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: SizeUtils.m),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (al?.madeWithFlutter ?? 'Realizado con Flutter').toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize:
                      TextStyleSize.textDescriptionSize(screenWidth) * 0.85,
                  fontWeight: FontWeight.w500,
                  color: UtilsColor.colorMuted,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.flutter_dash,
                color: UtilsColor.colorBlue.withValues(alpha: 0.9),
                size: 18,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
