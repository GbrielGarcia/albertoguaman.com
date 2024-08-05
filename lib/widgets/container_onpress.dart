import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/utils.dart';

Widget containerOnpress(VoidCallback onPressed, String title,
    {bool? activate, TextStyle? style, IconData? icon, Color? color}) {
  return Stack(
    children: [
      Container(
        color: Colors.transparent,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all( color ?? Colors.blue),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                FaIcon(
                  icon ?? FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                ),
                const SizedBox(width: 4.0),
                Text(
                  title,
                  style: style ??
                      StyleText.textStyleClass(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      Visibility(
        visible: activate ?? true,
        child: Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            height: 10,
            width: 10,
            color: Colors.brown,
          ),
        ),
      ),
      Visibility(
        visible: activate ?? true,
        child: Positioned(
          right: 0,
          top: 0,
          child: Container(
            height: 10,
            width: 10,
            color: Colors.brown,
          ),
        ),
      ),
      Visibility(
        visible: activate ?? true,
        child: Positioned(
          child: Container(
            height: 10,
            width: 10,
            color: Colors.brown,
          ),
        ),
      ),
      Visibility(
        visible: activate ?? true,
        child: Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: 10,
            width: 10,
            color: Colors.brown,
          ),
        ),
      ),
    ],
  );
}
