import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/utils.dart';

class CupertinoSwitchW extends StatelessWidget {
  final TextStyle textStyle;

  final bool activate;
  const CupertinoSwitchW({
    Key? key,
    required this.textStyle,
    required this.activate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var language = Provider.of<LocaleProvider>(context);

    return Container(
      width: 150,
      decoration: true == activate
          ? BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            )
          : BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsUtil.imgBackgroundMinecraft,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('  EN', style: textStyle),
          CupertinoSwitch(
            onChanged: (bool value) {
              value == true
                  ? language.changeLocale(const Locale('es'))
                  : language.changeLocale(const Locale('en'));
            },
            value: language.locale == const Locale('en') ? false : true,
          ),
          Text(
            'ES  ',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
