import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget iconWidget(IconData fontIcon, VoidCallback inkWell) {
  return InkWell(
    onTap: inkWell,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: FaIcon(
        fontIcon,
        color: Colors.white,
      ),
    ),
  );
}