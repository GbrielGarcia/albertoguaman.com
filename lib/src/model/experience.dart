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
    title: 'Freelancer',
    description: [
      '- Administración y mantenimiento de sitios web optimizando el rendimiento y mejorando la seguridad.',
      '- Desarrollo web y aplicaciones móviles con Flutter, HTML, JavaScript, CSS y Wordpres.',
      '- Administración y mantenimiento de sitios web optimizando el rendimiento y mejorando la seguridad.',
      '- Estrategias de email marketing y automatización de correos para optimizar la comunicación con clientes.',
    ],
    type: 'Publicidad Digital y Desarrollador',
    data: '∞',
    country: 'Ecuador ',
  ),
  Experience(
    title: 'Sciedtec',
    description: [
      '- Creación y optimización de campañas en Meta Business Suite (Facebook e Instagram Ads).',
      '- Mantenimiento y actualización de contenido, optimización de rendimiento y SEO para mejorar la visibilidad online.',
      '- Respuesta a consultas, interacción con clientes y fortalecimiento de la presencia online de la empresa.',
    ],
    type: 'Publicidad y Marketing',
    data: '2024 Febrero - 2024 Septiembre',
    country: 'Ecuador ',
  ),
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
    data: '2022 Marzo - 2024 Enero',
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
    type: 'Desarrollador y Consultor',
    data: '2020 Febrero - ∞',
    country: 'Ecuador ',
  ),
];
