/**
 * Perfil profesional (← lib/src/model/*.dart y lib/l10n/app_es.arb del sitio Flutter).
 * Textos copiados tal cual; solo se adaptó la forma de los datos.
 */

export const HERO = {
  greeting: '¡Hola, Mundo! Yo soy',
  roles: 'Encargado Comercial | Inventarios | Coordinación de Equipos | Atención al Cliente | Soporte Técnico',
  rolesShort: 'Encargado Comercial | Inventarios | Soporte Técnico',
};

/** CV principal (← AssetsUtil.cvDev2026). Los demás PDFs siguen en /cv/ con su URL de siempre. */
export const CV_URL = '/cv/2026_cv_st.pdf';

/** ← siteAvailability en availability.dart */
export const AVAILABILITY = {
  status: 'Abierto a oportunidades',
  location: 'Ecuador (GMT-5)',
  workMode: 'Remoto · híbrido · presencial según acuerdo',
  contract: 'Tiempo completo · proyectos · soporte continuo',
  preferredStack: 'Soporte L1/L2 IT · Helpdesk · Flutter · Dart · Firebase · Full Stack',
  note: 'Busco roles de soporte técnico L1/L2 IT y desarrollo donde pueda aportar criterio, seguimiento y resultados.',
};

/** ← descriptionAbout en app_es.arb (párrafos). */
export const ABOUT = [
  'Soy tecnólogo en desarrollo de software. Trabajo entre el desarrollo de soluciones y el soporte técnico / IT. He dado soporte L1/L2 de informática a más de 16 sucursales a nivel nacional (hardware, software, tickets y acompañamiento remoto). Esta cobertura incluye la atención y el acompañamiento tecnológico a más de 200 colaboradores internos.',
  'Mi experiencia combina Flutter, Dart, Firebase, Git y stack web; además, uso IA (Cursor, Claude / Anthropic y modelos predictivos) para escribir, revisar y depurar con mayor rapidez y criterio técnico.',
];

export interface Experience {
  company: string;
  role: string;
  period: string;
  country: string;
  stack: string;
  highlights: string[];
}

/** ← infoExperienceModel en experience.dart (el primero es el puesto más reciente). */
export const EXPERIENCE: Experience[] = [
  {
    company: 'MI CHANCE',
    role: 'Soporte Técnico L1/L2 IT',
    period: 'Febrero 2026 – Agosto 2026 (7 meses)',
    country: 'Ecuador',
    stack: 'Soporte L1/L2 IT, helpdesk, gestión de incidencias, soporte a sucursales, diagnóstico técnico, escalamiento.',
    highlights: [
      'Soporte técnico nivel 1 y nivel 2 en Informática / IT a más de 16 sucursales a nivel nacional.',
      'Atención y acompañamiento tecnológico a más de 200 colaboradores internos.',
      'Atención y resolución de incidencias de hardware, software y sistemas operativos.',
      'Diagnóstico técnico, clasificación y seguimiento de tickets hasta su cierre.',
      'Soporte remoto y acompañamiento a usuarios de puntos de atención en todo el país.',
      'Escalamiento controlado de casos complejos y documentación de soluciones.',
    ],
  },
  {
    company: 'NOVISOLUTIONS',
    role: 'Encargado Comercial',
    period: 'Julio 2025 – Enero 2026 (7 meses)',
    country: 'Ecuador',
    stack: 'Sistema de facturación MBA 3, control de inventario, auditoría de caja, KPIs de ventas y gestión de personal.',
    highlights: [
      'Administración integral de la operación diaria y supervisión del local comercial.',
      'Coordinación de personal, asignación de tareas y liderazgo del equipo de trabajo.',
      'Control riguroso de inventario, stock y movimientos de mercancía mediante MBA 3.',
      'Gestión del ciclo completo de ventas, facturación y asesoría comercial de alto nivel.',
      'Dirección de estrategias de postventa, resolución de incidencias y fidelización de clientes.',
      'Ejecución de procesos administrativos, cierres de caja, arqueos y validación de documentación.',
    ],
  },
  {
    company: 'SCIEDTEC',
    role: 'Coordinador de Helpdesk y Soporte Técnico · Full Stack Web - Mobile',
    period: 'Enero 2022 – Junio 2025 (3 años 6 meses)',
    country: 'Ecuador',
    stack: 'Flutter, Dart, Firebase, Moodle, Power BI, Meta Business Suite, Helpdesk, CMS, LMS, HTML, CSS, SEO y MySQL.',
    highlights: [
      'Coordinación del área de soporte técnico: helpdesk, incidencias y acompañamiento a clientes y personal interno.',
      'Optimización de procesos de soporte, reducción de tiempos de respuesta y capacitación técnica.',
      'Administración de plataformas Moodle, sitios web institucionales y disponibilidad de infraestructura.',
      'Desarrollo de aplicaciones móviles con Flutter para gestión institucional.',
      'Campañas digitales y segmentación en Meta Business Suite; SEO y actualización de contenido.',
      'Fortalecimiento de presencia digital e interacción con la comunidad online.',
    ],
  },
  {
    company: 'TINGUAR',
    role: 'Desarrollador Full Stack Web & Mobile',
    period: 'Enero 2020 – Diciembre 2021 (2 años)',
    country: 'Ecuador',
    stack: 'Flutter, Dart, Firebase, WordPress, WooCommerce, Odoo, Webflow, HTML, CSS, JavaScript, Git, PostgreSQL, MySQL y VPS.',
    highlights: [
      'Desarrollo de aplicaciones móviles multiplataforma con Flutter y Firebase.',
      'Creación de sitios web responsivos y desarrollo web personalizado.',
      'Implementación de e-commerce con WordPress, WooCommerce y Odoo.',
      'Integración de pasarelas de pago y módulos dinámicos.',
      'Optimización SEO, rendimiento y experiencia de usuario.',
      'Gestión técnica completa: análisis, desarrollo, despliegue y soporte.',
    ],
  },
];

/** Suma de los "(x años y meses)" de cada experiencia (← totalExperienceDurationLabel). */
export function totalExperienceLabel(items: Experience[] = EXPERIENCE): string | null {
  let months = 0;
  for (const e of items) {
    const inner = e.period.match(/\(([^)]+)\)/)?.[1] ?? '';
    months += Number(inner.match(/(\d+)\s*años?/)?.[1] ?? 0) * 12;
    months += Number(inner.match(/(\d+)\s*mes(es)?/)?.[1] ?? 0);
  }
  if (months <= 0) return null;
  const y = Math.floor(months / 12);
  const m = months % 12;
  const years = y === 1 ? '1 año' : `${y} años`;
  const rest = m === 1 ? '1 mes' : `${m} meses`;
  if (y > 0 && m > 0) return `${years} ${rest}`;
  return y > 0 ? years : rest;
}

export interface SkillGroup {
  title: string;
  subtitle: string;
  items: string[];
}

/** ← infoSkillGroups en skill.dart */
export const SKILL_GROUPS: SkillGroup[] = [
  {
    title: 'Desarrollo',
    subtitle: 'Apps, web y datos',
    items: ['Flutter', 'Dart', 'Firebase', 'Git', 'HTML', 'CSS', 'JavaScript', 'MySQL', 'PostgreSQL'],
  },
  {
    title: 'Soporte / IT',
    subtitle: 'Helpdesk y operación técnica',
    items: ['Helpdesk', 'Soporte L1 / L2', 'Incidencias', 'Hardware / software', 'Moodle', 'Power BI'],
  },
  {
    title: 'Web y plataformas',
    subtitle: 'CMS, e-commerce y hosting',
    items: ['WordPress', 'WooCommerce', 'Odoo', 'Webflow', 'Meta Business', 'VPS'],
  },
  {
    title: 'IA y productividad',
    subtitle: 'Asistentes y flujo de trabajo',
    items: ['Cursor', 'Claude (Anthropic)', 'Modelos predictivos', 'Asistentes de código'],
  },
];

/** Herramienta → proyectos donde la usé (← skillToProjectTitles). Lo usará el stack interactivo (fase 4). */
export const SKILL_PROJECTS: Record<string, string[]> = {
  Flutter: ['Tarot Pragmático - Calculadora de Arcanos', 'Mi Negocio Listo'],
  Dart: ['Tarot Pragmático - Calculadora de Arcanos', 'Mi Negocio Listo'],
  Firebase: ['Tarot Pragmático - Calculadora de Arcanos', 'Mi Negocio Listo'],
  Git: ['Rapidito', 'Mi Negocio Listo', 'Streaming Ecuador - Distribuidores'],
  HTML: ['Streaming Ecuador', 'Tatiana Jiménez Abogada', 'EMAPASOSQ-EP'],
  CSS: ['Streaming Ecuador', 'Tatiana Jiménez Abogada'],
  JavaScript: ['Streaming Ecuador', 'Tarot Pragmático'],
  MySQL: ['Streaming Ecuador - Distribuidores', 'Mi Negocio Listo'],
  PostgreSQL: ['Rapidito'],
  Helpdesk: ['Soporte L1/L2 · Mi Chance (experiencia)'],
  'Soporte L1 / L2': ['Soporte L1/L2 · Mi Chance (experiencia)'],
  Incidencias: ['Soporte L1/L2 · Mi Chance (experiencia)'],
  'Hardware / software': ['Soporte L1/L2 · Mi Chance (experiencia)'],
  WordPress: ['EMAPASOSQ-EP', 'Inox Hierro', 'Lars Tree Services'],
  WooCommerce: ['Inox Hierro'],
  VPS: ['Streaming Ecuador - Distribuidores', 'Rapidito'],
  Cursor: ['Portafolio albertoguaman.com', 'Productos Tinguar'],
  'Claude (Anthropic)': ['Portafolio albertoguaman.com', 'Productos Tinguar'],
};

export interface Project {
  title: string;
  tags: string[];
  description: string;
  url: string;
}

/** ← infoProjectModel en project.dart (solo proyectos con enlace público). */
export const PROJECTS: Project[] = [
  {
    title: 'Rapidito',
    tags: ['Desktop', 'WhatsApp', 'Tinguar'],
    description:
      'Campañas de WhatsApp desde tu PC (Windows y macOS), con ritmo controlado. Sube tu lista CSV, personaliza mensajes con variables, adjunta archivos y envía con licencia por equipo e auto-update.',
    url: 'https://tinguar.com/productos/rapidito/',
  },
  {
    title: 'Mi Negocio Listo',
    tags: ['POS', 'Web', 'Android', 'Tinguar'],
    description:
      'POS, facturación electrónica SRI, inventario, caja y catálogo digital para una o varias tiendas. Vende en mostrador y en línea, imprime tickets térmicos y envía comprobantes por WhatsApp. Web: minegociolisto.com · App Android en Google Play.',
    url: 'https://minegociolisto.com/',
  },
  {
    title: 'Streaming Ecuador - Distribuidores',
    tags: ['Streaming', 'Web'],
    description:
      'Panel de distribuidores para comprar, renovar y administrar cuentas de streaming con saldo, entrega inmediata y renovación sin perder datos.',
    url: 'https://distribuidores.streamingecu.com/',
  },
  {
    title: 'Streaming Ecuador',
    tags: ['Streaming', 'Web'],
    description: 'Sitio web informativo SEO Friendly para Streaming Ecuador, desarrollado con Astro y Tailwind CSS.',
    url: 'https://streamingecu.com/',
  },
  {
    title: 'Tarot Pragmático - Calculadora de Arcanos',
    tags: ['Flutter', 'Dart', 'Web'],
    description:
      'Perfil de Arcano Personal y mapas de tarot en Flutter (Android y Web): cálculo por fecha de nacimiento, mapas anuales y comparación de vínculo.',
    url: 'https://perfil.tarotpragmatico.com/',
  },
  {
    title: 'Tarot Pragmático',
    tags: ['Web', 'Astro'],
    description: 'Plataforma web de tarot pragmático con lecturas personalizadas y consultas espirituales.',
    url: 'https://tarotpragmatico.com/',
  },
  {
    title: 'EMAPASOSQ-EP',
    tags: ['WordPress', 'Web'],
    description:
      'Sitio institucional de la Empresa Municipal de Agua Potable y Alcantarillado (Quinindé): transparencia, denuncia ciudadana, bolsa de empleo y blog.',
    url: 'https://emapasosq-ep.gob.ec/',
  },
  {
    title: 'Tatiana Jiménez Abogada',
    tags: ['Astro', 'Web'],
    description:
      'Sitio profesional para abogada en Derecho Penal, Tránsito, Civil y Familia, con servicios, consultas en línea y contacto.',
    url: 'https://tatianaabogada.com/',
  },
  {
    title: 'Inox Hierro',
    tags: ['WordPress', 'Web'],
    description:
      'Sitio web para fabricación de pasamanos en acero inoxidable y accesorios para barandillas y vidrio templado.',
    url: 'https://inoxhierroec.com/',
  },
  {
    title: 'Lars Tree Services',
    tags: ['WordPress', 'Web'],
    description: 'Sitio web de servicios de cuidado de árboles: poda, remoción, trasplante y mantenimiento.',
    url: 'https://www.larstreeservice.info',
  },
  {
    title: 'Daniel Jaramillo Abogado',
    tags: ['WordPress', 'Web'],
    description: 'Sitio profesional de servicios jurídicos: asesoría, patrocinio y defensa legal.',
    url: 'https://daniel-jaramillo-abogados.com/',
  },
];

/** Herramienta → proyectos, con el enlace público del proyecto cuando existe (← projectsForSkill). */
export function skillUsage(): Record<string, { title: string; url?: string }[]> {
  return Object.fromEntries(
    Object.entries(SKILL_PROJECTS).map(([skill, titles]) => [
      skill,
      titles.map((title) => ({
        title,
        url: PROJECTS.find((p) => p.title === title || title.includes(p.title))?.url,
      })),
    ]),
  );
}

/** ← infoClientNames en client.dart */
export const CLIENTS = [
  'All Clean Ways',
  'EMAPASOSQ-EP',
  'Tatiana Jiménez Abogada',
  'LiliBot',
  'Tarot Pragmático',
  'Tarot Pragmático - Calculadora de Arcanos',
  'Streaming Ecuador',
  'Axxo Imagen',
  'Inox Hierro',
  'Sciedtec',
  'Lars Tree Services',
  'Ml Digital',
  'Arminox',
  'David Streaming',
  'Daniel Jaramillo Abogado',
  'Agleview Restoration LLC',
  'Lili Gestion',
];

export interface Publication {
  title: string;
  type: 'Artículo' | 'Libro';
  date: string;
  doi: string;
  url: string;
  description: string;
}

/** ← infoBookModel en book.dart */
export const PUBLICATIONS: Publication[] = [
  {
    title: 'Impacto del uso de flutter en el rendimiento académico de estudiantes de un instituto tecnológico',
    type: 'Artículo',
    date: '2024-08-21',
    doi: '10.37811/cl_rcm.v8i4.12588',
    url: 'https://doi.org/10.37811/cl_rcm.v8i4.12588',
    description:
      'Este estudio investiga el impacto del uso de Flutter en el rendimiento académico de los estudiantes de un instituto tecnológico. Se utilizó un diseño experimental con una muestra de 150 estudiantes de diversas carreras tecnológicas, divididos en un grupo experimental que usó Flutter y un grupo control con métodos tradicionales. Los resultados mostraron que el uso de Flutter mejoró significativamente el rendimiento académico, la satisfacción y la participación de los estudiantes. Estos hallazgos tienen implicaciones importantes para el desarrollo de programas educativos y políticas institucionales.',
  },
  {
    title: 'Manejo Eficaz de Aulas Virtuales: Guía Completa para Educadores',
    type: 'Libro',
    date: '2024-11-06',
    doi: '10.37811/cli_w1119',
    url: 'https://doi.org/10.37811/cli_w1119',
    description:
      'En los últimos años, la educación ha experimentado una transformación significativa, impulsada por los avances tecnológicos y la creciente demanda de flexibilidad en los entornos de aprendizaje. Las aulas virtuales, una vez vistas como una alternativa complementaria a la educación tradicional, se han convertido en una parte integral del panorama educativo moderno. Este libro, “Manejo Eficaz de Aulas Virtuales: Guía Completa para Educadores”, surge de la necesidad de ofrecer una guía exhaustiva y práctica para aquellos que buscan mejorar la experiencia educativa en el entorno digital.',
  },
];
