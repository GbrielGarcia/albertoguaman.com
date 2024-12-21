import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget tooltipW(String message, Widget child) {
  return Tooltip(
    padding: EdgeInsets.all(SizeUtils.m),
    message: message,
    textStyle: StyleText.textPortfolio(fontSize: SizeUtils.s1),
    margin: EdgeInsets.all(SizeUtils.m),
    decoration: BoxDecoration(
        color: UtilsColor.colorPrimaryDark,
        border: Border.all(color: UtilsColor.colorSecondaryWhite),
        borderRadius: BorderRadius.circular(SizeUtils.m)),
    child: child,
  );
}