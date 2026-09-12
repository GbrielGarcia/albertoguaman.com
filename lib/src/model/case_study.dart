/// Casos de estudio para el portafolio (problema → solución → resultado).
class CaseStudy {
  final String title;
  final String contextLabel;
  final String role;
  final String problem;
  final String solution;
  final String stack;
  final List<String> results;
  final String? beforeLabel;
  final String? afterLabel;
  final List<String> metrics;
  final String? linkUrl;
  final String? linkLabel;

  const CaseStudy({
    required this.title,
    required this.contextLabel,
    required this.role,
    required this.problem,
    required this.solution,
    required this.stack,
    required this.results,
    this.beforeLabel,
    this.afterLabel,
    this.metrics = const [],
    this.linkUrl,
    this.linkLabel,
  });
}

const List<CaseStudy> infoCaseStudies = [
  CaseStudy(
    title: 'MDM y soporte IT a escala nacional',
    contextLabel: 'MI CHANCE',
    role: 'Desarrollo Java (MDM) + Soporte L1/L2 IT',
    problem:
        'Había que rastrear y gestionar equipos empresariales, y al mismo tiempo '
        'sostener soporte técnico L1/L2 en más de 16 sucursales con cientos de colaboradores.',
    solution:
        'Desarrollé módulos en Java para una plataforma MDM orientada al rastreo '
        'y la gestión de equipos, y operé helpdesk con diagnóstico, tickets, '
        'soporte remoto y escalamiento controlado.',
    stack: 'Java · MDM · Helpdesk · Soporte L1/L2 · Incidencias',
    beforeLabel:
        'Soporte disperso, poca trazabilidad de equipos y tickets sin cierre claro.',
    afterLabel:
        'MDM en producción + helpdesk con ciclo de ticket documentado a escala nacional.',
    metrics: [
      '+16 sucursales',
      '+200 colaboradores',
      '7 meses de operación',
      'Tickets: diagnóstico → cierre',
    ],
    results: [
      '+16 sucursales atendidas a nivel nacional',
      '+200 colaboradores con acompañamiento tecnológico',
      'Módulos MDM en producción para rastreo y gestión de equipos',
      'Ciclo de tickets desde diagnóstico hasta cierre documentado',
    ],
  ),
  CaseStudy(
    title: 'Productos digitales Tinguar',
    contextLabel: 'TINGUAR',
    role: 'Desarrollo de productos (Flutter / web)',
    problem: 'Negocios y equipos comerciales necesitaban herramientas propias: '
        'campañas de WhatsApp controladas y un POS con facturación electrónica SRI.',
    solution:
        'Construí y mantuve productos como Rapidito (campañas WhatsApp desde escritorio) '
        'y Mi Negocio Listo (POS, inventario, caja y catálogo digital), '
        'además de sitios y paneles para clientes del portafolio.',
    stack: 'Flutter · Dart · Web · WhatsApp · POS · Facturación SRI',
    beforeLabel:
        'Campañas manuales y venta sin un sistema propio de inventario/caja.',
    afterLabel:
        'Productos en producción con licencia, auto-update, POS + SRI y catálogo online.',
    metrics: [
      '2 productos bandera',
      'Windows / macOS + Android / Web',
      'Clientes con sitios públicos',
    ],
    results: [
      'Rapidito: envíos por CSV, variables, adjuntos y licencia por equipo',
      'Mi Negocio Listo: POS + SRI + catálogo online + tickets térmicos',
      'Portafolio de clientes con sitios públicos desplegados',
    ],
    linkUrl: 'https://tinguar.com/productos/rapidito/',
    linkLabel: 'Ver Rapidito',
  ),
  CaseStudy(
    title: 'Streaming Ecuador — panel de distribuidores',
    contextLabel: 'STREAMING ECUADOR',
    role: 'Desarrollo web / e-commerce operativo',
    problem:
        'Los distribuidores necesitaban comprar, renovar y administrar cuentas '
        'con saldo, entrega inmediata y sin perder datos en renovaciones.',
    solution: 'Armé un panel web de distribuidores con flujo de recargas, '
        'gestión de inventario en tiempo real y renovación controlada.',
    stack: 'PHP · MySQL · Laravel · Bootstrap',
    beforeLabel:
        'Renovaciones frágiles y riesgo de perder datos de cuenta al renovar.',
    afterLabel:
        'Panel en producción con saldo, entrega inmediata y renovación segura.',
    metrics: [
      'Panel 24/7',
      'Inventario en tiempo real',
      'Renovación sin pérdida de datos',
    ],
    results: [
      'Panel de distribuidores en producción',
      'Renovación sin pérdida de datos de cuenta',
      'Sitio informativo SEO Friendly (Astro) como complemento',
    ],
    linkUrl: 'https://distribuidores.streamingecu.com/',
    linkLabel: 'Ver panel',
  ),
];
