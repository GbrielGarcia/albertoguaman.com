import 'package:flutter/foundation.dart';

import 'seo_stub.dart' if (dart.library.html) 'seo_web.dart' as impl;

/// Actualiza título y meta description de la página (solo web con JS). En WASM no hace nada.
void setPageSEO({
  required String title,
  required String description,
  String? path,
  String? imageUrl,
}) {
  if (!kIsWeb) return;
  impl.setPageSEO(
    title: title,
    description: description,
    path: path,
    imageUrl: imageUrl,
  );
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
      '/blog': (
        'Blog · Desarrollo, Flutter y tecnología',
        'Artículos de Alberto Guaman sobre Flutter, Dart, web, hosting, Linux y más. '
            'Tutoriales y notas prácticas de desarrollo.',
      ),
      '/galeria': (
        'Galería · Momentos del día a día',
        'Una mirada a algunos momentos de Alberto Guaman: trabajo, proyectos y día a día.',
      ),
      '/contacto': (
        'Contacto · WhatsApp, redes y CV',
        'Contacta a Alberto Guaman por email (contacto@albertoguaman.com), '
            'WhatsApp, LinkedIn o descarga el CV.',
      ),
      '/casos': (
        'Casos de estudio · Problema, solución y resultados',
        'Casos de estudio de Alberto Guaman: MDM e IT a escala nacional, '
            'productos Tinguar y paneles operativos en producción.',
      ),
      '/recomendaciones': (
        'Recomendaciones · Reseñas de clientes',
        'Reseñas de clientes de proyectos desarrollados con Tinguar.',
      ),
      '/cv': (
        'CV · Currículum',
        'Vista previa e impresión del CV de Alberto Guaman.',
      ),
    };
