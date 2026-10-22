import 'package:flutter/foundation.dart';

import 'seo_stub.dart' if (dart.library.html) 'seo_web.dart' as impl;

/// Imagen por defecto al compartir (foto del CV, servida desde `web/`).
const String defaultShareImagePath = '/alberto_cv_photo.jpg';

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
        'Portafolio · Soporte L1/L2 IT · Flutter · Full Stack',
        'Portafolio de Alberto Guaman (Ecuador): soporte técnico L1/L2 IT, '
            'Flutter, Dart, Firebase y productos digitales.',
      ),
      '/bio': (
        'Sobre mí · Perfil profesional',
        'Conoce a Alberto Guaman: tecnólogo en desarrollo de software, '
            'soporte L1/L2 IT, Flutter y stack web. Contacto y redes.',
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
        'Casos de estudio de Alberto Guaman: soporte IT a escala nacional, '
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
      '/servicios': (
        'Servicios · Soporte, Flutter, web y e-commerce',
        'Paquetes de servicio: soporte técnico, apps Flutter, desarrollo web, '
            'e-commerce y software a medida.',
      ),
      '/faq': (
        'Cómo trabajo · FAQ',
        'Proceso, tiempos, herramientas y comunicación con Alberto Guaman.',
      ),
      '/changelog': (
        'Cambios · albertoguaman.com',
        'Qué he ido cambiando en el portafolio y cuándo.',
      ),
      '/flores-amarillas': (
        'Flores amarillas',
        'Un regalo digital especial.',
      ),
      '/nosotros': (
        'Nosotros · Johanna & Gabriel',
        'Una historia en fotos: casa, mesas y momentos de Johanna y Gabriel.',
      ),
    };
