/**
 * Servicios, casos, reseñas, FAQ y changelog (← lib/src/model/*.dart del sitio Flutter).
 */

export interface Service {
  id: string;
  title: string;
  outcome: string;
  pitch: string;
  description: string;
  highlights: string[];
  includes: string[];
  cta: string;
}

/** ← infoServiceOffers en service_offer.dart */
export const SERVICES: Service[] = [
  {
    id: 'soporte',
    title: 'Soporte técnico',
    outcome: 'Cuando algo falla, hay respuesta',
    pitch: 'Incidencias, mantenimiento y respaldos. Priorizo recuperar tu operación.',
    description:
      'Soporte remoto y preventivo para webs y sistemas en producción. Helpdesk con diagnóstico, tickets y cierre documentado.',
    highlights: ['Remoto', 'Preventivo', 'Rápido'],
    includes: [
      'Canal de soporte acordado',
      'Atención de incidencias',
      'Mantenimiento preventivo',
      'Respaldos y recuperación',
      'Cierre con lo resuelto',
    ],
    cta: 'Necesito soporte',
  },
  {
    id: 'flutter',
    title: 'Apps Flutter',
    outcome: 'Una app que tu cliente o equipo sí va a usar',
    pitch: 'Android y/o iOS (y web). Menos fricción, más control del servicio desde el celular.',
    description: 'Apps a medida con Flutter: fluídas, integradas a tu operación y listas para publicar.',
    highlights: ['iOS / Android', 'Útil de verdad', 'Integrable'],
    includes: [
      'Alcance de la primera versión',
      'Flujos y pantallas clave',
      'App Android y/o iOS (y web si aplica)',
      'Integración con backend o APIs',
      'Acompañamiento en publicación',
    ],
    cta: 'Quiero una app',
  },
  {
    id: 'web',
    title: 'Desarrollo web',
    outcome: 'Una web que explica, genera confianza y convierte',
    pitch: 'No solo “se ve bonita”: se entiende en segundos y lleva al contacto o a la venta.',
    description: 'Sitios y landings claros, rápidos y pensados para móvil. Marca + conversión.',
    highlights: ['Móvil primero', 'Rápida', 'Lista para vender'],
    includes: [
      'Estructura de mensajes y páginas',
      'Diseño alineado a tu marca',
      'Sitio responsive y rápido',
      'Contacto y CTAs listos',
      'Publicación + revisión básica',
    ],
    cta: 'Quiero mejorar mi web',
  },
  {
    id: 'ecommerce',
    title: 'E-commerce y operación',
    outcome: 'Vender y controlar sin perder el orden',
    pitch: 'Catálogo, inventario, caja y paneles operativos: lo que tu equipo usa todos los días.',
    description:
      'E-commerce y sistemas de venta (POS, catálogos, paneles de distribuidores) con foco en operación real.',
    highlights: ['Catálogo', 'Inventario', 'Operación'],
    includes: [
      'Diagnóstico de tu flujo de venta',
      'Primera versión usable (MVP)',
      'Integraciones de pago o WhatsApp si aplica',
      'Capacitación corta al arranque',
    ],
    cta: 'Quiero vender online',
  },
  {
    id: 'software',
    title: 'Software a medida',
    outcome: 'Un sistema propio que ordena tu operación',
    pitch:
      'Dejo de lado plantillas genéricas. Construyo lo que tu negocio necesita para vender, controlar y crecer.',
    description:
      'Software a medida: gestión, paneles, APIs e integraciones. Por etapas, con entregas visibles.',
    highlights: ['A medida', 'Por etapas', 'Integrable'],
    includes: [
      'Diagnóstico rápido de tu operación',
      'Primera versión usable (MVP) priorizada',
      'Panel, roles y reportes',
      'Integraciones con lo que ya usas',
      'Puesta en marcha y capacitación corta',
    ],
    cta: 'Quiero un sistema a medida',
  },
];

export interface CaseStudy {
  title: string;
  context: string;
  role: string;
  problem: string;
  solution: string;
  stack: string;
  before?: string;
  after?: string;
  metrics: string[];
  results: string[];
  link?: { url: string; label: string };
}

/** ← infoCaseStudies en case_study.dart */
export const CASE_STUDIES: CaseStudy[] = [
  {
    title: 'Soporte IT a escala nacional',
    context: 'MI CHANCE',
    role: 'Soporte Técnico L1/L2 IT',
    problem:
      'Había que sostener soporte técnico L1/L2 en más de 16 sucursales con cientos de colaboradores: hardware, software, tickets y acompañamiento remoto.',
    solution:
      'Operé helpdesk con diagnóstico, clasificación de tickets, soporte remoto y escalamiento controlado hasta el cierre documentado.',
    stack: 'Helpdesk · Soporte L1/L2 · Incidencias · Hardware / software',
    before: 'Soporte disperso y tickets sin cierre claro en puntos de atención.',
    after: 'Helpdesk con ciclo de ticket documentado a escala nacional.',
    metrics: ['+16 sucursales', '+200 colaboradores', '7 meses de operación', 'Tickets: diagnóstico → cierre'],
    results: [
      '+16 sucursales atendidas a nivel nacional',
      '+200 colaboradores con acompañamiento tecnológico',
      'Ciclo de tickets desde diagnóstico hasta cierre documentado',
      'Escalamiento controlado de casos complejos',
    ],
  },
  {
    title: 'Productos digitales Tinguar',
    context: 'TINGUAR',
    role: 'Desarrollo de productos (Flutter / web)',
    problem:
      'Negocios y equipos comerciales necesitaban herramientas propias: campañas de WhatsApp controladas y un POS con facturación electrónica SRI.',
    solution:
      'Construí y mantuve productos como Rapidito (campañas WhatsApp desde escritorio) y Mi Negocio Listo (POS, inventario, caja y catálogo digital), además de sitios y paneles para clientes del portafolio.',
    stack: 'Flutter · Dart · Web · WhatsApp · POS · Facturación SRI',
    before: 'Campañas manuales y venta sin un sistema propio de inventario/caja.',
    after: 'Productos en producción con licencia, auto-update, POS + SRI y catálogo online.',
    metrics: ['2 productos bandera', 'Windows / macOS + Android / Web', 'Clientes con sitios públicos'],
    results: [
      'Rapidito: envíos por CSV, variables, adjuntos y licencia por equipo',
      'Mi Negocio Listo: POS + SRI + catálogo online + tickets térmicos',
      'Portafolio de clientes con sitios públicos desplegados',
    ],
    link: { url: 'https://tinguar.com/productos/rapidito/', label: 'Ver Rapidito' },
  },
  {
    title: 'Streaming Ecuador — panel de distribuidores',
    context: 'STREAMING ECUADOR',
    role: 'Desarrollo web / e-commerce operativo',
    problem:
      'Los distribuidores necesitaban comprar, renovar y administrar cuentas con saldo, entrega inmediata y sin perder datos en renovaciones.',
    solution:
      'Armé un panel web de distribuidores con flujo de recargas, gestión de inventario en tiempo real y renovación controlada.',
    stack: 'PHP · MySQL · Laravel · Bootstrap',
    before: 'Renovaciones frágiles y riesgo de perder datos de cuenta al renovar.',
    after: 'Panel en producción con saldo, entrega inmediata y renovación segura.',
    metrics: ['Panel 24/7', 'Inventario en tiempo real', 'Renovación sin pérdida de datos'],
    results: [
      'Panel de distribuidores en producción',
      'Renovación sin pérdida de datos de cuenta',
      'Sitio informativo SEO Friendly (Astro) como complemento',
    ],
    link: { url: 'https://distribuidores.streamingecu.com/', label: 'Ver panel' },
  },
];

export interface Testimonial {
  quote: string;
  name: string;
  initials: string;
  date: string;
}

/** ← infoTestimonials en testimonial.dart (reseñas de clientes de Tinguar). */
export const TESTIMONIALS: Testimonial[] = [
  { quote: 'Excelente profesional, rápido y amable en todo el proceso de lo que necesitas crear.', name: 'Raúl Muñoz Jara', initials: 'RM', date: '2024-08-13' },
  { quote: 'Tinguar es una empresa de diseño web de primer nivel que superó todas mis expectativas. La calidad de su trabajo es impecable.', name: 'Bryan German Leon Rueda', initials: 'BL', date: '2024-02-22' },
  { quote: 'Excelente servicio, me ayudo con mi pagina EEUU. Lo recomiendo 100%.', name: 'Jorge Luis', initials: 'JL', date: '2024-04-26' },
  { quote: 'Excelente servicio, me realizo la pagina web y va de maravilla. Recomendable.', name: 'Daniel Jaramillo', initials: 'DJ', date: '2024-03-04' },
  { quote: 'Excelente servicio y atención, recomendado llevo años con esta empresa y son muy profesionales.', name: 'Adrian Alejandro Villena', initials: 'AV', date: '2023-06-06' },
  { quote: 'El gerente excelente profesional, realizó nuestra página para el centro pre universitario.. 10 / 10', name: 'Carranza Luis', initials: 'CL', date: '2023-09-02' },
  { quote: 'Increíble trabajo, muy profesional y puntual. Mi sitio web quedó perfecto.', name: 'María González', initials: 'MG', date: '2024-01-15' },
  { quote: 'Excelente atención al cliente y resultados sobresalientes. Altamente recomendado.', name: 'Carlos Rodríguez', initials: 'CR', date: '2024-05-20' },
  { quote: 'Trabajo de calidad superior, entregaron antes de lo esperado. Muy satisfecho.', name: 'Ana Martínez', initials: 'AM', date: '2024-03-18' },
  { quote: 'Profesionales de primera, entendieron perfectamente lo que necesitaba.', name: 'Luis Fernández', initials: 'LF', date: '2024-06-10' },
  { quote: 'Servicio excepcional, comunicación clara y resultados excelentes.', name: 'Patricia Silva', initials: 'PS', date: '2024-04-05' },
  { quote: 'Equipo muy competente, transformaron mi idea en una realidad digital increíble.', name: 'Roberto Torres', initials: 'RT', date: '2024-07-22' },
  { quote: 'Pedí un POS para mi tienda y al final me ayudaron hasta con el ticket de la impresora térmica. Antes tenía todo en cuaderno jaja.', name: 'Karina Espinoza', initials: 'KE', date: '2025-02-11' },
  { quote: 'La verdad se demoraron un poquito al inicio pero me avisaron. La web quedó bien y me enseñaron a subir productos yo mismo.', name: 'Miguel Ángel Paredes', initials: 'MP', date: '2025-05-03' },
  { quote: 'Buscaba algo para controlar renovaciones de streaming y ya no pelear con Excel. Me salió mucho más ordenado de lo que imaginaba.', name: 'Diego Cárdenas', initials: 'DC', date: '2025-08-19' },
  { quote: 'Hicieron la página de mi consultorio. Nada exagerado, limpia y fácil de leer. Mis pacientes ahora agendan por WhatsApp sin problema.', name: 'Dra. Verónica Acosta', initials: 'VA', date: '2024-11-28' },
  { quote: 'Lo bueno es que contestan. Uno escribe a las 9 de la noche y al día siguiente ya tienen avance. Yo soy de Cuenca y todo fue remoto.', name: 'Esteban Mora', initials: 'EM', date: '2025-01-17' },
  { quote: 'Nos armó un panel chiquito para el inventario de 2 locales. No es un monstruo de software, es justo lo que necesitábamos.', name: 'Paola Ríos', initials: 'PR', date: '2025-03-09' },
  { quote: 'Me hicieron landing de un curso online. En 2 semanas ya tenía formulario y pagos. Precio razonable frente a otras cotizaciones.', name: 'Andrés Villacís', initials: 'AV', date: '2024-09-14' },
  { quote: 'Había trabajado con otro provider y me dejaron botado. Aquí por lo menos explican qué están haciendo y por qué.', name: 'Sofía Naranjo', initials: 'SN', date: '2025-06-21' },
  { quote: 'App android para mi equipo de ventas. Falló un detalle al principio, lo corrigieron el mismo viernes. Eso me convenció.', name: 'Héctor Zambrano', initials: 'HZ', date: '2025-04-02' },
  { quote: 'No soy técnica, solo quería una web seria para mi marca de ropa. Me guiaron sin hablar en código y quedó linda.', name: 'Camila Ordóñez', initials: 'CO', date: '2025-07-08' },
  { quote: 'Llevo el hosting con ellos desde el 2023. Si algo se cae, avisan. Eso vale oro cuando uno vende online.', name: 'Jaime Maldonado', initials: 'JM', date: '2025-09-25' },
];

export interface FaqItem {
  question: string;
  answer: string;
}

/** ← infoFaqHowIWork en faq_item.dart */
export const FAQ: FaqItem[] = [
  {
    question: '¿Cómo arranca un proyecto contigo?',
    answer:
      'Primero alineamos objetivo, alcance y urgencia (mensaje o llamada corta). Luego propongo un plan por etapas con entregas visibles: no “caja negra”.',
  },
  {
    question: '¿Cuánto tarda una primera versión?',
    answer:
      'Depende del alcance. Una landing o ajuste puede ir en días; un MVP de app o panel suele ir por sprints semanales con demos. Lo importante: ves avance, no solo promesas.',
  },
  {
    question: '¿Con qué herramientas trabajas?',
    answer:
      'Flutter/Dart, web (HTML/CSS/JS, Astro, WordPress), Git, Firebase, helpdesk y stack de operación (inventario, facturación, paneles). Uso IA (Cursor, Claude) para acelerar sin soltar el criterio de lo que se entrega.',
  },
  {
    question: '¿Cómo nos comunicamos?',
    answer:
      'WhatsApp o email para el día a día; videollamada cuando hace falta decidir. Dejo registro de acuerdos, pendientes y próximos pasos para que no se pierda el hilo.',
  },
  {
    question: '¿Haces soporte después de entregar?',
    answer:
      'Sí. Puedo acompañar con soporte remoto, mantenimiento preventivo y mejoras. Acordamos canal, horarios y prioridades antes de empezar.',
  },
  {
    question: '¿Trabajas remoto o presencial?',
    answer:
      'Base en Ecuador (GMT-5). Remoto a nivel nacional e internacional; presencial cuando el proyecto lo requiere y se acuerda.',
  },
];

export interface ChangelogEntry {
  date: string;
  title: string;
  items: string[];
}

/** ← infoChangelog en changelog_entry.dart (+ la entrada de la migración a Astro). */
export const CHANGELOG: ChangelogEntry[] = [
  {
    date: 'Octubre 2026',
    title: 'Nuevo sitio en Astro',
    items: [
      'Dejé Flutter web y rehíce el sitio en Astro: HTML real, carga mucho más rápida y mejor para buscadores.',
      'El blog pasó a ser parte central del sitio, con temas, índice en cada artículo y RSS arreglado.',
      'Mismas direcciones de siempre: /blog, /casos, /cv y el resto siguen funcionando.',
    ],
  },
  {
    date: 'Septiembre 2026',
    title: 'Lo que faltaba para cerrar el ciclo',
    items: [
      'Armé /servicios con lo que ya ofrezco (soporte, Flutter, web, e-commerce).',
      'Dejé por escrito cómo trabajo: FAQ, disponibilidad y stack al clic.',
      'En /casos metí antes/después y números concretos, no solo el relato.',
      'Saqué el inglés del sitio. Si alguien entra, que lea en español y punto.',
      'Arreglé el amarillo en tema claro: se veía horrible.',
    ],
  },
  {
    date: 'Marzo 2025',
    title: 'Cuando el portafolio se volvió sitio de verdad',
    items: [
      'Subí blog, casos, recomendaciones y una vista de CV.',
      'Header fijo, splash y el año de fondo: detalles que noté que faltaban.',
      'Hostinger me rompía /blog y /cv; lo dejé resuelto en el .htaccess.',
    ],
  },
  {
    date: 'Junio 2023',
    title: 'Más contenido, menos “landing vacía”',
    items: [
      'Agregué proyectos y clientes para que se vea qué he hecho.',
      'Contacto y galería: lo básico para que alguien te escriba.',
      'Títulos y descripciones por ruta para que Google no vea una sola página.',
    ],
  },
  {
    date: '2020',
    title: 'Arranque',
    items: [
      'Primera versión de albertoguaman.com. Nada fancy: perfil, experiencia y skills.',
      'Desde ahí lo vengo tocando cada vez que el portafolio se me queda corto.',
    ],
  },
];
