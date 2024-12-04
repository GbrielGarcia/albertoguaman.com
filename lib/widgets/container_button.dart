import 'package:albertoguaman/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../home/porfolio/porfolio.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContainerButtonWidget extends StatefulWidget {
  AppLocalizations? al;
  String text;
  Color? color;
  Color? colorText;
  VoidCallback onTap;
  String? message;
  ContainerButtonWidget(
      {super.key,
      required this.al,
      required this.text,
      required this.onTap,
      this.color,
      this.colorText,
      this.message});

  @override
  State<ContainerButtonWidget> createState() => _ContainerButtonWidgetState();
}

class _ContainerButtonWidgetState extends State<ContainerButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message ?? '',
      textStyle: StyleText.textStyleOriginalDark(
        fontSize: SizeUtils.l,
      ),
      decoration: BoxDecoration(
          color: UtilsColor.colorOriginalPorfolioG
      ),
      child: InkWell(
        onTap: widget.onTap,
        hoverColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: widget.color ?? UtilsColor.colorHomePrimaryRed,
              borderRadius: BorderRadius.all(Radius.circular(SizeUtils.s)),
              border: Border.all(
                  color:
                      widget.color == null ? UtilsColor.colorDarkGrey : Colors.black)),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.xl, vertical: SizeUtils.m),
              child: ResponsiveText(
                text: widget.text,
                minSize: SizeUtils.l, // 20
                maxSize: SizeUtils.l1, // 25
                style: StyleText.textStyleOriginalDark(
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
