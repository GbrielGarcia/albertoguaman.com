import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'widget.dart';

Widget containerBottom(VoidCallback onTap, String message, String text,
    {Color? color, Color? colorBorder, double? padding, double? width}) {
  return Padding(
    padding: EdgeInsets.all(padding ?? SizeUtils.s),
    child: tooltipW(
        message,
        InkWell(
          hoverColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            width: width,
            decoration: BoxDecoration(
                color: color ?? UtilsColor.colorSecondaryWhite,
                border: Border.all(),
                borderRadius: BorderRadius.circular(SizeUtils.m)),
            child: Padding(
              padding: EdgeInsets.all(SizeUtils.s),
              child: Text(
                text.toUpperCase(),
                style: StyleText.textPortfolio(
                    fontSize: SizeUtils.s1,
                    fontWeight: FontWeight.w500,
                    color: UtilsColor.colorPrimaryDark),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )),
  );
}
