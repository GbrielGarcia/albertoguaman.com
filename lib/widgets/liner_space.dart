import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget linerSpace() {
  return Container(
      height: 2.0, width: double.infinity, color: UtilsColor.colorSecondaryWhite);
}

Widget linerSpaceV( BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: 1.0,
    child: DecoratedBox(
      decoration: BoxDecoration(color: UtilsColor.colorDarkGrey),
    ),
  );
}
