import 'package:flutter/widgets.dart';

import 'cv_preview_stub.dart'
    if (dart.library.html) 'cv_preview_web.dart' as impl;

/// Vista previa del CV (iframe en web; fallback en otras plataformas).
Widget buildCvPreview({
  required String pdfUrl,
  double height = 640,
}) {
  return impl.buildCvPreview(pdfUrl: pdfUrl, height: height);
}
