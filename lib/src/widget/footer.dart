import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/utils.dart';

Widget footerData(AppLocalizations? al, double screenWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('${al!.madeWithFlutter} 💕'.toUpperCase(),
          style: StyleText.textPortfolio(
            fontSize: TextStyleSize.textDescriptionSize(screenWidth),
            fontWeight: FontWeight.bold,
          )),
      const Icon(
        Icons.flutter_dash,
        color: Colors.lightBlue,
      )
    ],
  );
}