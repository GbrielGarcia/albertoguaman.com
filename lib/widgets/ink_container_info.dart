import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/utils.dart';
import 'widgets.dart';

class InkeContainerInfo extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String? title;
  final bool? activate;
  const InkeContainerInfo({
    super.key,
    required this.onTap,
    required this.text,
    this.title,
    this.activate,
  });

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);

    return Tooltip(
      textStyle: StyleText.textStyleClassClasi(color: Colors.white),
      message: al!.open.toUpperCase(),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: activate ?? false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    title ?? 'd',
                    style: StyleText.textStyleClassClasi(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: Responsive.isDesktop(context) ? 500 : 450,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text.toUpperCase(),
                      style: StyleText.textStyleClassClasi(
                          fontWeight: FontWeight.w400),
                    ),
                    const ColorCycleIcon(),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: Responsive.isDesktop(context) ? 500 : 450,
                height: 1.0,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
