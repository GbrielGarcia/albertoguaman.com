import 'package:albertoguaman/src/widget/size_text.dart';
import 'package:albertoguaman/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme();

  // do Light Theme later
  TextTheme lightTextTheme(double screenWidth) => TextTheme(
        headlineLarge: _alegreya(
          fontSize: 55.0.sizeScaled(screenWidth, minSize: 25),
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: _alegreya(
          fontSize: 35.0.sizeScaled(screenWidth, minSize: 18),
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: _alegreya(
          fontSize: 22.0.sizeScaled(screenWidth, minSize: 17),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: _alegreya(
          fontSize: SizeUtils.l.sizeScaled(screenWidth, minSize: SizeUtils.s1),
            color: UtilsColor.colorPrimaryDark
        ),
        bodyMedium: _alegreya(
          fontSize: 14.0.sizeScaled(screenWidth, minSize: 12),
        ),
        bodySmall: _alegreya(
          fontSize: 14.0.sizeScaled(screenWidth, minSize: 12),
        ),
        // buttons
        labelLarge: _alegreya(
          fontSize: 22.0.sizeScaled(screenWidth, minSize: 18),
        ),
      );

  ///  Dark Text Theme
  TextTheme darkTextTheme(double screenWidth) => TextTheme(
        headlineLarge: _alegreya(
          fontSize: 55.0.sizeScaled(screenWidth, minSize: 25),
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: _alegreya(
          fontSize: 35.0.sizeScaled(screenWidth, minSize: 18),
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: _alegreya(
          fontSize: 22.0.sizeScaled(screenWidth, minSize: 17),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: _alegreya(
          fontSize: SizeUtils.l.sizeScaled(screenWidth, minSize: SizeUtils.s1),
          color: UtilsColor.colorSecondaryWhite
        ),
        bodyMedium: _alegreya(
          fontSize: 14.0.sizeScaled(screenWidth, minSize: 12),
        ),
        bodySmall: _alegreya(
          fontSize: 14.0.sizeScaled(screenWidth, minSize: 12),
        ),
        // buttons
        labelLarge: _alegreya(
          fontSize: 22.0.sizeScaled(screenWidth, minSize: 18),
        ),
      );

  TextStyle _alegreya({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.alegreya(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}
