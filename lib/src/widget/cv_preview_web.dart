// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

bool _registered = false;

Widget buildCvPreview({
  required String pdfUrl,
  double height = 640,
}) {
  const viewType = 'alberto-cv-pdf-preview';
  if (!_registered) {
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final iframe = html.IFrameElement()
        ..src = pdfUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'fullscreen';
      return iframe;
    });
    _registered = true;
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(SizeUtils.l),
    child: Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: UtilsColor.colorElevated,
        border: Border.all(
          color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(SizeUtils.l),
      ),
      child: const HtmlElementView(viewType: viewType),
    ),
  );
}
