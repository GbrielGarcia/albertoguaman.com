
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/utils.dart';

Widget containerOnpress(VoidCallback onPressed, String title) {
  return Stack(
    children: [
      Container(
        color: Colors.transparent,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0),
                Text(
                  title,
                  style: StyleText.textStyleClass(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
    ],
  );
}
