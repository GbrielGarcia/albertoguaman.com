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
        'Portafolio · Desarrollo, Soporte y Productos Digitales',
        'Portafolio de Alberto Guaman (Ecuador): desarrollo Java para MDM y '
            'gestión de equipos empresariales, soporte L1/L2 IT '
            '(más de 16 sucursales), desarrollo Flutter/web y productos Tinguar '
            '(Rapidito, Mi Negocio Listo, Streaming Distribuidores).',
      ),
      '/bio': (
        'Sobre mí · Perfil profesional',
        'Conoce a Alberto Guaman: trayectoria en soporte técnico, desarrollo full stack '
            'web y móvil, gestión comercial y productos digitales. Contacto y redes.',
      ),
    };
