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
    title: 'SCIDETEC',
    description: [
      '- Coordinación de plataformas educativas Moodle, incluyendo administración, personalización y soporte a usuarios (docentes y administrativos)',
      '- Gestión de helpdesk e incidencias, resolviendo problemas técnicos de manera eficiente',
      '- Desarrollo e implementación de aplicaciones móviles con Flutter para automatizar procesos académicos y administrativos',
      '- Mantenimiento preventivo de infraestructura tecnológica y soporte helpdesk, asegurando la continuidad operativa institucional',
      '- Capacitación a docentes en el uso de tecnologías emergentes y herramientas digitales educativas',
      '- Diseño y ejecución de campañas publicitarias en Facebook e Instagram Ads (Meta Business Suite), optimizando segmentación, rendimiento y alcance',
      '- Actualización y mantenimiento de contenido digital, mejorando la visibilidad online mediante buenas prácticas SEO',
      '- Gestión de la comunidad online, incluyendo respuesta a consultas e interacción con usuarios para fortalecer la presencia digital de la empresa',
    ],
    type: 'Administrador & Desarrollador Full Stack Web - Mobile',
    data: 'Marzo de 2022 - Abril de 2024 (2 año 1 meses) ',
    country: 'Ecuador ',
  ),
  Experience(
    title: 'TINGUAR',
    description: [
      '- Diseño y desarrollo de aplicaciones móviles multiplataforma con Flutter, integrando autenticación, notificaciones push, mapas interactivos y bases de datos en tiempo real (Firebase/Firestore)',
      '- Creación de sitios web modernos, accesibles y responsivos utilizando Webflow y desarrollo personalizado con HTML, CSS y JavaScript, garantizando compatibilidad multiplataforma y experiencia de usuario fluida',
      '- Implementación de soluciones e-commerce con WordPress, WooCommerce y Odoo, desarrollando módulos a medida, configurando pasarelas de pago e integrando herramientas de gestión empresarial',
      '- Optimización técnica y de contenidos para SEO, velocidad de carga y accesibilidad, mejorando el posicionamiento en buscadores y la conversión de usuarios',
      '- Integración de componentes dinámicos como formularios inteligentes, chats en línea y enlaces de contacto directo',
      '- Consultoría técnica personalizada, acompañando a clientes en todas las etapas del proyecto: análisis, desarrollo, despliegue y soporte postproducción',
    ],
    type: 'Desarrollador Full Stack Web & Mobile',
    data: 'Febrero de 2020 - Enero de 2022 (1 año 11 meses) ',
    country: 'Ecuador ',
  )
];
