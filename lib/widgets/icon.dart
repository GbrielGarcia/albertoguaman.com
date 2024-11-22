import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/utils.dart';

Widget iconWidget(
  IconData fontIcon,
  VoidCallback inkWell, {
  Color? color,
  String? message,
}) {
  return Tooltip(
    message: message ?? '',
    textStyle: StyleText.textStyleOriginalDark(
      fontSize: SizeUtils.l,
      ),
    decoration: BoxDecoration(
      color: UtilsColor.colorOriginalPorfolioG
    ),
    child: InkWell(
      hoverColor: Colors.transparent,
      onTap: inkWell,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FaIcon(
          fontIcon,
          color: color ?? Colors.white,
          size: SizeUtils.l2,

        ),
      ),
    ),
  );
}
