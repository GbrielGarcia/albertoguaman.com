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
      fontSize: fontSize ?? 35.0,
      color: color ??  Colors.black,
      fontWeight: fontWeight ?? FontWeight.w100
    ));
  }
}
