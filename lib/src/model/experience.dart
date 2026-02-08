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
    title: 'NOVISOLUTIONS',
    stack: 'Sistema de facturación MBA 3, gestión administrativa, control de inventario, ventas, atención al cliente',
    description: [
      '- Administro la operación diaria del local, asegurando el correcto funcionamiento de las actividades comerciales.',
      '- Superviso los procesos de ventas, facturación e inventario utilizando el sistema MBA 3.',
      '- Coordino al personal del local, organizando turnos y asignando responsabilidades.',
      '- Controlo el stock, así como los ingresos y egresos de productos.',
      '- Garantizo una atención eficiente al cliente y una correcta gestión postventa.',
      '- Implemento mejoras operativas para optimizar tiempos y el orden administrativo.',
    ],
    type: 'Administrador Comercial del Local Importadora Novoa - Bomboli Shopping',
    data: 'Enero 2026 – Actualidad',
    country: 'Ecuador',
  ),
  Experience(
    title: 'NOVISOLUTIONS',
    stack: 'Sistema de facturación MBA 3, atención al cliente, gestión de ventas, control de inventario',
    description: [
      '- Gestioné el proceso completo de venta de productos tecnológicos, desde la atención al cliente hasta la facturación.',
      '- Utilicé el sistema de facturación MBA 3 para registrar ventas, emitir comprobantes y controlar el inventario.',
      '- Asesoré a clientes en la selección de equipos y soluciones tecnológicas según sus necesidades.',
      '- Mantuve un control preciso de stock y movimientos de productos.',
      '- Garanticé una atención personalizada, fortaleciendo la confianza y fidelización de clientes.',
      '- Coordiné con el área administrativa para asegurar la correcta facturación y cierre de ventas.',
    ],
    type: 'Asesor Comercial en Soluciones Tecnológicas en Novicompu',
    data: 'Octubre 2025 – Diciembre 2025 (3 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'SCIDETEC',
    stack: 'Meta Business Suite, Moodle, sistema propio de Helpdesk, CMS y LMS',
    description: [
      '- Dirigí el área de helpdesk, administrando la recepción y resolución de incidencias técnicas mediante un sistema de soporte interno.',
      '- Proporcioné soporte continuo a clientes y personal, garantizando la operatividad de las soluciones implementadas.',
      '- Administré plataformas educativas y sitios web (CMS y Moodle), asegurando su seguridad y disponibilidad permanente.',
      '- Implementé mejoras en el flujo de soporte, reduciendo tiempos de resolución y optimizando la experiencia del usuario.',
      '- Organicé capacitaciones técnicas para personal docente y administrativo sobre el uso de herramientas digitales.',
    ],
    type: 'Coordinador de Helpdesk y Soporte Técnico',
    data: 'Febrero 2025 – Julio 2025 (6 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'SCIDETEC',
    stack: 'Flutter, Dart, Firebase, Moodle, Power BI, Meta Business Suite, HTML, CSS, SEO, MySQL',
    description: [
      '- Gestioné plataformas educativas Moodle: administración, personalización y asistencia a docentes y administrativos.',
      '- Atendí incidencias técnicas y helpdesk, resolviendo problemas de manera ágil y eficiente.',
      '- Desarrollé aplicaciones móviles con Flutter para procesos académicos y administrativos.',
      '- Aseguré el mantenimiento de la infraestructura tecnológica, garantizando su disponibilidad.',
      '- Capacité a docentes en tecnologías educativas emergentes.',
      '- Diseñé campañas digitales en Meta Business Suite, optimizando alcance y segmentación.',
      '- Actualicé y gestioné contenido digital con técnicas SEO para mejorar la visibilidad institucional.',
      '- Interactué con la comunidad online, fortaleciendo la presencia digital de la empresa.',
    ],
    type: 'Administrador y Desarrollador Full Stack Web - Mobile',
    data: 'Marzo 2022 – Octubre 2024 (2 años 7 meses)',
    country: 'Ecuador',
  ),
  Experience(
    title: 'TINGUAR',
    stack: 'Flutter, Dart, Firebase, WordPress, Odoo, WooCommerce, Webflow, HTML, CSS, JavaScript, Git, PostgreSQL, MySQL, VPS',
    description: [
      '- Emprendimiento propio desde 2020, enfocado en desarrollo web, móvil y soluciones digitales.',
      '- Desarrollé aplicaciones móviles multiplataforma en Flutter, integrando autenticación, notificaciones y bases de datos en tiempo real.',
      '- Creé sitios web responsivos en Webflow y con desarrollo personalizado (HTML, CSS, JS).',
      '- Implementé soluciones e-commerce con WordPress, WooCommerce y Odoo, incluyendo pasarelas de pago y módulos personalizados.',
      '- Optimicé sitios web en SEO, rendimiento y accesibilidad, aumentando visibilidad y conversión.',
      '- Integré funcionalidades dinámicas como chats en línea y formularios inteligentes.',
      '- Brindé consultoría técnica en todas las fases del proyecto: análisis, desarrollo, despliegue y soporte.',
    ],
    type: 'Emprendimiento · Desarrollador Full Stack Web & Mobile',
    data: 'Desde 2020',
    country: 'Ecuador',
  )
];
