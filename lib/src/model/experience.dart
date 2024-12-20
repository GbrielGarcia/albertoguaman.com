class Experience {
  final String title;
  final List<String> description;
  final String type;
  final String data;
  final String country;

  Experience({
    required this.title,
    required this.description,
    required this.type,
    required this.data,
    required this.country,
  });
}

List<Experience> infoExperienceModel = [
  Experience(
    title: 'Sciedtec',
    description: [
      '- Gestión de helpdesk e incidencias, resolviendo problemas técnicos de manera eficiente.',
      '- Análisis de datos y mantenimiento de sitios educativos con Moodle.',
      '- Automatización de procesos y mantenimiento preventivo de equipos.',
      '- Desarrollo e implementación de software utilizando Flutter.',
      '- Instructora de cursos de aplicaciones móviles y web.',
    ],
    type: 'Administrador de TI',
    data: '2022 - 2024',
    country: 'Ecuador ',
  ),
  Experience(
    title: 'Tinguar',
    description: [
      '- Desarrollo de aplicaciones móviles y web utilizando Flutter.',
      '- Consultoría en el desarrollo de aplicaciones móviles con Flutter.',
      '- Desarrollo web con HTML, JavaScript, CSS y Webflow.',
      '- Creación de tiendas en línea utilizando Odoo, WooCommerce y WordPress.',
      '- Instructora de cursos de aplicaciones móviles y web.',
    ],
    type: 'Autonomo',
    data: '2020 - ∞',
    country: 'Ecuador ',
  ),
];
