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

List<Experience> infoExperienceModel = [
  Experience(
    title: 'GRUPO CONSENSO',
    stack:
        'RPX, SAP 3, análisis crediticio, buró de crédito, gestión de cartera, crédito directo, evaluación financiera, validación documental, atención al cliente.',
    description: [
      '- Evaluación y análisis de clientes para aprobación de crédito directo.',
      '- Gestión y seguimiento de cartera de clientes.',
      '- Análisis de buró crediticio y riesgo financiero.',
      '- Registro y validación de operaciones en RPX y SAP 3.',
      '- Atención y asesoramiento comercial personalizado.',
      '- Coordinación de procesos financieros para toma de decisiones.',
    ],
    type: 'Analista Comercial / Gestión de Cartera',
    data: 'Febrero 2026 – Actualidad',
    country: 'Ecuador',
  ),
  Experience(
    title: 'NOVISOLUTIONS',
    stack:
        'Sistema de facturación MBA 3, atención al cliente, gestión de ventas, control de inventario',
    description: [
      '- Gestión integral de ventas, facturación y cierre comercial.',
      '- Atención y asesoría personalizada a clientes.',
      '- Administración operativa y supervisión diaria del local.',
      '- Control de inventario, stock y movimientos en MBA 3.',
      '- Coordinación de personal y asignación de tareas.',
      '- Gestión postventa y fidelización de clientes.',
      '- Control administrativo, cierres de caja y documentación.',
      '- Optimización de procesos y eficiencia operativa.',
    ],
    type: 'Asesor Comercial & Administrador Comercial en Novicompu',
    data: 'Septiembre 2025 – Enero 2026 (5 meses) ',
    country: 'Ecuador',
  ),
  Experience(
    title: 'SCIDETEC',
    stack:
        'Meta Business Suite, Moodle, sistema propio de Helpdesk, CMS y LMS.',
    description: [
      '- Coordinación y gestión integral del área de soporte técnico.',
      '- Administración y resolución eficiente de incidencias mediante sistema helpdesk.',
      '- Soporte continuo a clientes y personal interno.',
      '- Gestión y mantenimiento de plataformas educativas y sitios web.',
      '- Optimización de procesos de soporte y reducción de tiempos de respuesta.',
      '- Capacitación técnica a personal docente y administrativo.',
    ],
    type: 'Coordinador de Helpdesk y Soporte Técnico',
    data: 'Febrero 2025 – Julio 2025 (6 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'SCIDETEC',
    stack:
        'Flutter, Dart, Firebase, Moodle, Power BI, Meta Business Suite, HTML, CSS, SEO, MySQL',
    description: [
      '- Administración y optimización de plataformas Moodle para procesos académicos y administrativos.',
      '- Soporte técnico y resolución ágil de incidencias (helpdesk).',
      '- Desarrollo de aplicaciones móviles con Flutter para gestión institucional.',
      '- Mantenimiento y disponibilidad de infraestructura tecnológica.',
      '- Capacitación a personal docente en herramientas tecnológicas.',
      '- Gestión de campañas digitales y segmentación estratégica en Meta Business Suite.',
      '- Optimización SEO y actualización de contenido institucional.',
      '- Fortalecimiento de presencia digital e interacción con la comunidad online.',
    ],
    type: 'Administrador y Desarrollador Full Stack Web - Mobile',
    data: 'Marzo 2022 – Enero 2025 (2 años 10 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'TINGUAR',
    stack:
        'Flutter, Dart, Firebase, WordPress, Odoo, WooCommerce, Webflow, HTML, CSS, JavaScript, Git, PostgreSQL, MySQL, VPS',
    description: [
      '- Desarrollo de aplicaciones móviles multiplataforma con Flutter y Firebase.',
      '- Creación de sitios web responsivos y desarrollo web personalizado.',
      '- Implementación de e-commerce con WordPress, WooCommerce y Odoo.',
      '- Integración de pasarelas de pago y módulos dinámicos.',
      '- Optimización SEO, rendimiento y experiencia de usuario.',
      '- Gestión técnica completa: análisis, desarrollo, despliegue y soporte.',
    ],
    type: 'Emprendimiento · Desarrollador Full Stack Web & Mobile',
    data: 'Desde 2020',
    country: 'Ecuador',
  )
];
