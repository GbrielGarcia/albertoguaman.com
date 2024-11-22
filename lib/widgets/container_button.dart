import 'package:albertoguaman/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../home/porfolio/porfolio.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContainerButtonWidget extends StatelessWidget {
  AppLocalizations? al;
  String text;
  Color? color;
  Color? colorText;
  VoidCallback onTap;
  ContainerButtonWidget(
      {super.key,
        required this.al,
        required this.text,
        required this.onTap,
        this.color,
        this.colorText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? UtilsColor.colorHomePrimaryRed,
            borderRadius: BorderRadius.all(Radius.circular(SizeUtils.s)),
            border: Border.all(
                color:
                color == null ? UtilsColor.colorDarkGrey : Colors.black)),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.xl, vertical: SizeUtils.m),
            child: ResponsiveText(
              text: text,
              minSize: SizeUtils.l, // 20
              maxSize: SizeUtils.l1, // 25
              style:
              StyleText.textStyleOriginalDark(fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}