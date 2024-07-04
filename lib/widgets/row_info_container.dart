


import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget rowInfoContainer(String title, description) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
      top: 9.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 135.0,
          child: Text(
            title,
            style: StyleText.textStyleClass(
                fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            description,
            style: StyleText.textStyleClass(
                fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}




