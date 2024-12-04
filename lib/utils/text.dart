import 'package:albertoguaman/utils/color.dart';
import 'package:albertoguaman/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
  static TextStyle textStyleClass(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: 'Minecraftia',
      fontSize: fontSize ?? 20.0,
      fontWeight: fontWeight ?? FontWeight.w100,
      color: color ?? Colors.white,
    );
  }

  static TextStyle textStyleClassClasi(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 20.0,
      fontWeight: fontWeight ?? FontWeight.w100,
      color: color ?? Colors.black,
    );
  }

  static TextStyle textStyleOriginal({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.alegreya(textStyle: TextStyle(
      fontSize: fontSize ?? 20.0,
      color: color ??  UtilsColor.colorOriginalPorfolioW,
      fontWeight: fontWeight ?? FontWeight.w100
    ));
  }

  static TextStyle textStyleOriginalDark({
    double? fontSize,
    double? minFontSize,
    double? maxFontSize,
    Color? color,
    FontWeight? fontWeight,
    BuildContext? context, // Requiere el contexto para calcular el tamaño responsivo
  }) {
    double calculatedFontSize = fontSize ?? 25.0;

    // Si minFontSize y maxFontSize están definidos, ajustamos el tamaño
    if (context != null && (minFontSize != null || maxFontSize != null)) {
      final screenWidth = MediaQuery.of(context).size.width;
      calculatedFontSize = (screenWidth * 0.05).clamp(
        minFontSize ?? double.negativeInfinity,
        maxFontSize ?? double.infinity,
      );
    }

    return GoogleFonts.alegreya(
      textStyle: TextStyle(
        fontSize: calculatedFontSize,
        color: color ?? UtilsColor.colorDarkGrey,
        fontWeight: fontWeight ?? FontWeight.w100,
      ),
    );
  }


  static TextStyle textPortfolio({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    Color? colorBackgroundColor,
  }) {
    return GoogleFonts.alegreya(textStyle: TextStyle(
        fontSize: fontSize ?? SizeUtils.l,
        color: color ??  UtilsColor.colorSecondaryWhite,
        fontWeight: fontWeight ?? FontWeight.w100,
      backgroundColor:  colorBackgroundColor ?? Colors.transparent
    ));
  }

  static TextStyle textPortfolioDancingScript({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    Color? colorBackgroundColor,
  }) {
    return GoogleFonts.kaushanScript(textStyle: TextStyle(
        fontSize: fontSize ?? SizeUtils.l2,
        color: color ??  UtilsColor.colorPrimaryDark,
        fontWeight: fontWeight ?? FontWeight.bold,
        backgroundColor:  colorBackgroundColor ?? Colors.transparent
    ));
  }
}
