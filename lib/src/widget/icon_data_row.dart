
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/model.dart';
import '../utils/utils.dart';
import 'widget.dart';

Widget iconDataRow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: Wrap(
      alignment: WrapAlignment.start,
      spacing: SizeUtils.s1,
      runSpacing: SizeUtils.s1,
      children: infoButtonModel.map((button) {
        return tooltipW(
            button.url,
            Material(
              color: UtilsColor.colorSecondaryWhite,
              shape: const CircleBorder(),
              child: IconButton(
                icon: FaIcon(
                  button.icon,
                  color: UtilsColor.colorPrimaryDark,
                  size: SizeUtils.l2,
                ),
                onPressed: () => laucherURL(button.url),
                hoverColor: UtilsColor.colorPinkSecondary,
              ),
            ));
      }).toList(),
    ),
  );
}
