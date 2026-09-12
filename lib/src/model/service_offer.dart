/// Ofertas de servicio (copy adaptado de Tinguar → Alberto Guaman).
class ServiceOffer {
  final String id;
  final String title;
  final String outcome;
  final String pitch;
  final String description;
  final List<String> highlights;
  final List<String> features;
  final List<String> includes;
  final String ctaLabel;

  const ServiceOffer({
    required this.id,
    required this.title,
    required this.outcome,
    required this.pitch,
    required this.description,
    required this.highlights,
    required this.features,
    required this.includes,
    required this.ctaLabel,
  });
}

/// Paquetes claros: soporte, Flutter, web y e-commerce (+ software a medida).
const List<ServiceOffer> infoServiceOffers = [
  ServiceOffer(
    id: 'soporte',
    title: 'Soporte técnico',
    outcome: 'Cuando algo falla, hay respuesta',
    pitch:
        'Incidencias, mantenimiento y respaldos. Priorizo recuperar tu operación.',
    description:
        'Soporte remoto y preventivo para webs y sistemas en producción. Helpdesk con diagnóstico, tickets y cierre documentado.',
    highlights: ['Remoto', 'Preventivo', 'Rápido'],
    features: ['Soporte remoto', 'Mantenimiento', 'Respaldos'],
    includes: [
      'Canal de soporte acordado',
      'Atención de incidencias',
      'Mantenimiento preventivo',
      'Respaldos y recuperación',
      'Cierre con lo resuelto',
    ],
    ctaLabel: 'Necesito soporte',
  ),
  ServiceOffer(
    id: 'flutter',
    title: 'Apps Flutter',
    outcome: 'Una app que tu cliente o equipo sí va a usar',
    pitch:
        'Android y/o iOS (y web). Menos fricción, más control del servicio desde el celular.',
    description:
        'Apps a medida con Flutter: fluídas, integradas a tu operación y listas para publicar.',
    highlights: ['iOS / Android', 'Útil de verdad', 'Integrable'],
    features: ['Apps iOS y Android', 'Flutter Web', 'Integración con sistemas'],
    includes: [
      'Alcance de la primera versión',
      'Flujos y pantallas clave',
      'App Android y/o iOS (y web si aplica)',
      'Integración con backend o APIs',
      'Acompañamiento en publicación',
    ],
    ctaLabel: 'Quiero una app',
  ),
  ServiceOffer(
    id: 'web',
    title: 'Desarrollo web',
    outcome: 'Una web que explica, genera confianza y convierte',
    pitch:
        'No solo “se ve bonita”: se entiende en segundos y lleva al contacto o a la venta.',
    description:
        'Sitios y landings claros, rápidos y pensados para móvil. Marca + conversión.',
    highlights: ['Móvil primero', 'Rápida', 'Lista para vender'],
    features: [
      'Diseño responsive',
      'Optimización base SEO',
      'Enfocada en conversión',
    ],
    includes: [
      'Estructura de mensajes y páginas',
      'Diseño alineado a tu marca',
      'Sitio responsive y rápido',
      'Contacto y CTAs listos',
      'Publicación + revisión básica',
    ],
    ctaLabel: 'Quiero mejorar mi web',
  ),
  ServiceOffer(
    id: 'ecommerce',
    title: 'E-commerce y operación',
    outcome: 'Vender y controlar sin perder el orden',
    pitch:
        'Catálogo, inventario, caja y paneles operativos: lo que tu equipo usa todos los días.',
    description:
        'E-commerce y sistemas de venta (POS, catálogos, paneles de distribuidores) con foco en operación real.',
    highlights: ['Catálogo', 'Inventario', 'Operación'],
    features: [
      'Tienda / catálogo online',
      'POS e inventario',
      'Paneles de distribuidores',
    ],
    includes: [
      'Diagnóstico de tu flujo de venta',
      'Primera versión usable (MVP)',
      'Integraciones de pago o WhatsApp si aplica',
      'Capacitación corta al arranque',
    ],
    ctaLabel: 'Quiero vender online',
  ),
  ServiceOffer(
    id: 'software',
    title: 'Software a medida',
    outcome: 'Un sistema propio que ordena tu operación',
    pitch:
        'Dejo de lado plantillas genéricas. Construyo lo que tu negocio necesita para vender, controlar y crecer.',
    description:
        'Software a medida: gestión, paneles, APIs e integraciones. Por etapas, con entregas visibles.',
    highlights: ['A medida', 'Por etapas', 'Integrable'],
    features: ['Sistemas de gestión', 'Apps web a medida', 'APIs e integraciones'],
    includes: [
      'Diagnóstico rápido de tu operación',
      'Primera versión usable (MVP) priorizada',
      'Panel, roles y reportes',
      'Integraciones con lo que ya usas',
      'Puesta en marcha y capacitación corta',
    ],
    ctaLabel: 'Quiero un sistema a medida',
  ),
];
