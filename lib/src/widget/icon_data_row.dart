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
  // Los PNG son oscuros: el círculo debe ser claro en ambos temas.
  const circleBg = Color(0xFFFFFFFF);

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: Wrap(
      alignment: alignment,
      spacing: SizeUtils.m,
      runSpacing: SizeUtils.s1,
      children: infoButtonModel.map((button) {
        return tooltipW(
          button.url,
          Material(
            color: circleBg,
            elevation: 0,
            shape: CircleBorder(
              side: BorderSide(color: UtilsColor.hairline),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => laucherURL(button.url),
              hoverColor: UtilsColor.colorPinkSecondary.withValues(alpha: 0.35),
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.s),
                child: _socialIcon(button.name),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
