class Experience {
  final String title;
  final List<String> description;
  final String type;
  final String data;
  final String country;

  /// Tecnologías destacadas (se muestra aparte, no en la lista de descripción).
  final String? stack;

  Experience({
    required this.title,
    required this.description,
    required this.type,
    required this.data,
    required this.country,
    this.stack,
  });
}

/// Suma duraciones del texto entre paréntesis, p. ej. `(7 meses)` + `(2 años 9 meses)`.
String? totalExperienceDurationLabel(List<Experience> experiences) {
  var totalMonths = 0;
  for (final e in experiences) {
    totalMonths += _monthsFromExperienceData(e.data);
  }
  if (totalMonths <= 0) return null;
  return _formatDurationMonths(totalMonths);
}

int _monthsFromExperienceData(String data) {
  final paren = RegExp(r'\(([^)]+)\)').firstMatch(data);
  if (paren == null) return 0;
  final inner = paren.group(1)!;
  final yearsMatch = RegExp(r'(\d+)\s*años?').firstMatch(inner);
  final monthsMatch = RegExp(r'(\d+)\s*meses?').firstMatch(inner);
  final years = yearsMatch != null ? int.parse(yearsMatch.group(1)!) : 0;
  final months = monthsMatch != null ? int.parse(monthsMatch.group(1)!) : 0;
  return (years * 12) + months;
}

String _formatDurationMonths(int totalMonths) {
  final years = totalMonths ~/ 12;
  final months = totalMonths % 12;
  if (years > 0 && months > 0) {
    final yLabel = years == 1 ? 'año' : 'años';
    final mLabel = months == 1 ? 'mes' : 'meses';
    return '$years $yLabel $months $mLabel';
  }
  if (years > 0) {
    return years == 1 ? '1 año' : '$years años';
  }
  return months == 1 ? '1 mes' : '$months meses';
}

/// Experiencia alineada a los CVs (`2026_cv_st.pdf` y variantes).
List<Experience> infoExperienceModel = [
  Experience(
    title: 'MI CHANCE',
    stack:
        'Soporte L1/L2 IT, helpdesk, gestión de incidencias, soporte a sucursales, diagnóstico técnico, escalamiento.',
    description: [
      '- Soporte técnico nivel 1 y nivel 2 en Informática / IT a más de 16 sucursales a nivel nacional.',
      '- Atención y acompañamiento tecnológico a más de 200 colaboradores internos.',
      '- Atención y resolución de incidencias de hardware, software y sistemas operativos.',
      '- Diagnóstico técnico, clasificación y seguimiento de tickets hasta su cierre.',
      '- Soporte remoto y acompañamiento a usuarios de puntos de atención en todo el país.',
      '- Escalamiento controlado de casos complejos y documentación de soluciones.',
    ],
    type: 'Soporte Técnico L1/L2 IT',
    data: 'Febrero 2026 – Agosto 2026 (7 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'NOVISOLUTIONS',
    stack:
        'Sistema de facturación MBA 3, control de inventario, auditoría de caja, KPIs de ventas y gestión de personal.',
    description: [
      '- Administración integral de la operación diaria y supervisión del local comercial.',
      '- Coordinación de personal, asignación de tareas y liderazgo del equipo de trabajo.',
      '- Control riguroso de inventario, stock y movimientos de mercancía mediante MBA 3.',
      '- Gestión del ciclo completo de ventas, facturación y asesoría comercial de alto nivel.',
      '- Dirección de estrategias de postventa, resolución de incidencias y fidelización de clientes.',
      '- Ejecución de procesos administrativos, cierres de caja, arqueos y validación de documentación.',
    ],
    type: 'Encargado Comercial',
    data: 'Julio 2025 – Enero 2026 (7 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'SCIEDTEC',
    stack:
        'Flutter, Dart, Firebase, Moodle, Power BI, Meta Business Suite, Helpdesk, CMS, LMS, HTML, CSS, SEO y MySQL.',
    description: [
      '- Coordinación del área de soporte técnico: helpdesk, incidencias y acompañamiento a clientes y personal interno.',
      '- Optimización de procesos de soporte, reducción de tiempos de respuesta y capacitación técnica.',
      '- Administración de plataformas Moodle, sitios web institucionales y disponibilidad de infraestructura.',
      '- Desarrollo de aplicaciones móviles con Flutter para gestión institucional.',
      '- Campañas digitales y segmentación en Meta Business Suite; SEO y actualización de contenido.',
      '- Fortalecimiento de presencia digital e interacción con la comunidad online.',
    ],
    type:
        'Coordinador de Helpdesk y Soporte Técnico · Full Stack Web - Mobile',
    data: 'Enero 2022 – Junio 2025 (3 años 6 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'TINGUAR',
    stack:
        'Flutter, Dart, Firebase, WordPress, WooCommerce, Odoo, Webflow, HTML, CSS, JavaScript, Git, PostgreSQL, MySQL y VPS.',
    description: [
      '- Desarrollo de aplicaciones móviles multiplataforma con Flutter y Firebase.',
      '- Creación de sitios web responsivos y desarrollo web personalizado.',
      '- Implementación de e-commerce con WordPress, WooCommerce y Odoo.',
      '- Integración de pasarelas de pago y módulos dinámicos.',
      '- Optimización SEO, rendimiento y experiencia de usuario.',
      '- Gestión técnica completa: análisis, desarrollo, despliegue y soporte.',
    ],
    type: 'Desarrollador Full Stack Web & Mobile',
    data: 'Enero 2020 – Diciembre 2021 (2 años)',
    country: 'Ecuador',
  ),
];
