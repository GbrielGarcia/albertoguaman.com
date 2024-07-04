import 'package:flutter/material.dart';

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
}