import 'package:flutter/material.dart';
import 'package:albertoguaman/l10n/app_localizations.dart';

import '../utils/utils.dart';

Widget footerData(AppLocalizations? al, double screenWidth) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            '${al?.madeWithFlutter ?? ''} 💕'.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textDescriptionSize(screenWidth),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.flutter_dash,
          color: Colors.lightBlue,
          size: 20,
        ),
      ],
    ),
  );
}