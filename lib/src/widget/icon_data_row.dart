import 'package:flutter/material.dart';

import '../model/model.dart';
import '../utils/utils.dart';
import 'widget.dart';

Widget _socialIcon(String name) {
  final asset = switch (name) {
    'whatsapp' => 'assets/img/social/whatsapp.png',
    'linkedin' => 'assets/img/social/linkedin.png',
    'github' => 'assets/img/social/github.png',
    _ => 'assets/img/social/github.png',
  };

  return Image.asset(
    asset,
    width: SizeUtils.l2,
    height: SizeUtils.l2,
    filterQuality: FilterQuality.high,
  );
}

Widget iconDataRow({WrapAlignment alignment = WrapAlignment.center}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: Wrap(
      alignment: alignment,
      spacing: SizeUtils.s1,
      runSpacing: SizeUtils.s1,
      children: infoButtonModel.map((button) {
        return tooltipW(
            button.url,
            Material(
              color: UtilsColor.colorSecondaryWhite,
              shape: const CircleBorder(),
              child: IconButton(
                icon: _socialIcon(button.name),
                onPressed: () => laucherURL(button.url),
                hoverColor: UtilsColor.colorPinkSecondary,
              ),
            ));
      }).toList(),
    ),
  );
}
