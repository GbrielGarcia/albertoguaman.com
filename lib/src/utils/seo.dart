import 'package:flutter/foundation.dart';

import 'seo_stub.dart' if (dart.library.html) 'seo_web.dart' as impl;

/// Actualiza título y meta description de la página (solo web con JS). En WASM no hace nada.
void setPageSEO({
  required String title,
  required String description,
  String? path,
}) {
  if (!kIsWeb) return;
  impl.setPageSEO(title: title, description: description, path: path);
}

/// Datos SEO por ruta: título (corto) y descripción.
Map<String, (String title, String description)> get pageSeoData => {
      '/': (
        'Portafolio',
        'Portafolio de Alberto Guaman. Desarrollador, experiencia en sistemas, '
            'proyectos web y móviles. Flutter, análisis de datos, soluciones digitales.',
      ),
      '/bio': (
        'Sobre mí',
        'Conoce a Alberto Guaman. Perfil profesional, trayectoria y datos de contacto.',
      ),
    };
