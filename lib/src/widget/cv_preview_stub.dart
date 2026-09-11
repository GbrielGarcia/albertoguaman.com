import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

Widget buildCvPreview({
  required String pdfUrl,
  double height = 640,
}) {
  return Container(
    height: height,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: UtilsColor.colorElevated,
      borderRadius: BorderRadius.circular(SizeUtils.l),
      border: Border.all(
        color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.1),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(SizeUtils.l),
      child: Text(
        'Abre el CV para verlo en este dispositivo.',
        textAlign: TextAlign.center,
        style: StyleText.textPortfolio(
          color: UtilsColor.colorMuted,
          fontSize: SizeUtils.l,
        ),
      ),
    ),
  );
}
