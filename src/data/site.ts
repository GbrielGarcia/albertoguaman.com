/** Datos globales del sitio (antes en web/index.html y lib/src/utils/seo.dart). */
export const SITE = {
  name: 'Alberto Guaman',
  url: 'https://albertoguaman.com',
  locale: 'es_EC',
  lang: 'es',
  defaultTitle: 'Alberto Guaman | Portafolio · Desarrollo, Soporte y Productos Digitales',
  defaultDescription:
    'Portafolio de Alberto Guaman (Ecuador): soporte técnico L1/L2 IT, Flutter, Dart, Firebase y productos digitales.',
  defaultImage: '/alberto_cv_photo.jpg',
  defaultImageAlt: 'Alberto Guaman — foto de perfil',
  email: 'contacto@albertoguaman.com',
  whatsapp: 'https://wa.me/593992889078',
  adsenseClient: 'ca-pub-1686355120044737',
  /**
   * IDs de bloques de anuncio creados en AdSense (Anuncios → Por bloque de anuncios).
   * Vacíos = no se pinta ese bloque y AdSense decide con los anuncios automáticos.
   */
  adSlots: {
    /** "blog principal": listado de /blog, entre destacados y todos los artículos. */
    blogIndex: '9643035731',
    /** In-article (nativo): dentro de cada post, debajo de los dos primeros párrafos. */
    postInArticle: '2995408893',
    postTop: '',
    postBottom: '',
    postAside: '',
  },
  plausibleDomain: 'albertoguaman.com',
  /** Google Analytics 4 de la app web "alberto-guaman-dev" en Firebase (Firebase → Analytics). */
  gaMeasurementId: 'G-BPC7JT2RGJ',
} as const;

export const SOCIAL = [
  { label: 'GitHub', href: 'https://github.com/GbrielGarcia' },
  { label: 'LinkedIn', href: 'https://www.linkedin.com/in/albertoguaman' },
  { label: 'Tinguar', href: 'https://tinguar.com/' },
  { label: 'WhatsApp', href: SITE.whatsapp },
] as const;

/** Navegación principal (← lib/src/widget/site_nav.dart). */
export const NAV = [
  { href: '/', label: 'Inicio' },
  { href: '/servicios', label: 'Servicios' },
  { href: '/casos', label: 'Casos' },
  { href: '/recomendaciones', label: 'Reseñas' },
  { href: '/blog', label: 'Blog' },
  { href: '/galeria', label: 'Galería' },
  { href: '/contacto', label: 'Contacto' },
] as const;

/** Enlaces secundarios del footer (← lib/src/widget/footer.dart). */
export const FOOTER_NAV = [
  { href: '/bio', label: 'Sobre mí' },
  { href: '/servicios', label: 'Servicios' },
  { href: '/faq', label: 'FAQ' },
  { href: '/changelog', label: 'Cambios' },
  { href: '/cv', label: 'CV' },
  { href: '/galeria', label: 'Galería' },
  { href: '/blog/rss.xml', label: 'RSS' },
  { href: '/privacidad', label: 'Privacidad' },
  { href: '/terminos', label: 'Términos' },
] as const;

/** Título y descripción por ruta (← pageSeoData en lib/src/utils/seo.dart). */
export const PAGE_SEO: Record<string, { title: string; description: string }> = {
  '/': {
    title: 'Portafolio · Soporte L1/L2 IT · Flutter · Full Stack',
    description:
      'Portafolio de Alberto Guaman (Ecuador): soporte técnico L1/L2 IT, Flutter, Dart, Firebase y productos digitales.',
  },
  '/bio': {
    title: 'Sobre mí · Perfil profesional',
    description:
      'Conoce a Alberto Guaman: tecnólogo en desarrollo de software, soporte L1/L2 IT, Flutter y stack web. Contacto y redes.',
  },
  '/blog': {
    title: 'Blog · Desarrollo, Flutter y tecnología',
    description:
      'Artículos de Alberto Guaman sobre Flutter, Dart, web, hosting, Linux y más. Tutoriales y notas prácticas de desarrollo.',
  },
  '/galeria': {
    title: 'Galería · Momentos del día a día',
    description: 'Una mirada a algunos momentos de Alberto Guaman: trabajo, proyectos y día a día.',
  },
  '/contacto': {
    title: 'Contacto · WhatsApp, redes y CV',
    description:
      'Contacta a Alberto Guaman por email (contacto@albertoguaman.com), WhatsApp, LinkedIn o descarga el CV.',
  },
  '/casos': {
    title: 'Casos de estudio · Problema, solución y resultados',
    description:
      'Casos de estudio de Alberto Guaman: soporte IT a escala nacional, productos Tinguar y paneles operativos en producción.',
  },
  '/recomendaciones': {
    title: 'Recomendaciones · Reseñas de clientes',
    description: 'Reseñas de clientes de proyectos desarrollados con Tinguar.',
  },
  '/cv': {
    title: 'CV · Currículum',
    description: 'Vista previa e impresión del CV de Alberto Guaman.',
  },
  '/servicios': {
    title: 'Servicios · Soporte, Flutter, web y e-commerce',
    description:
      'Paquetes de servicio: soporte técnico, apps Flutter, desarrollo web, e-commerce y software a medida.',
  },
  '/faq': {
    title: 'Cómo trabajo · FAQ',
    description: 'Proceso, tiempos, herramientas y comunicación con Alberto Guaman.',
  },
  '/changelog': {
    title: 'Cambios · albertoguaman.com',
    description: 'Qué he ido cambiando en el portafolio y cuándo.',
  },
  '/privacidad': {
    title: 'Política de privacidad',
    description: 'Qué datos recoge albertoguaman.com, cómo se usan las cookies y los anuncios de Google AdSense.',
  },
  '/terminos': {
    title: 'Términos de uso',
    description: 'Condiciones de uso del contenido y del sitio albertoguaman.com.',
  },
};

/** JSON-LD base: WebSite + Person (← web/index.html). */
export const BASE_JSON_LD = [
  {
    '@type': 'WebSite',
    '@id': `${SITE.url}/#website`,
    url: `${SITE.url}/`,
    name: SITE.name,
    description:
      'Portafolio profesional de Alberto Guaman: desarrollo, soporte técnico y productos digitales.',
    inLanguage: 'es-EC',
    publisher: { '@id': `${SITE.url}/#person` },
  },
  {
    '@type': 'Person',
    '@id': `${SITE.url}/#person`,
    name: SITE.name,
    url: `${SITE.url}/`,
    image: `${SITE.url}${SITE.defaultImage}`,
    jobTitle: [
      'Tecnólogo superior en desarrollo de software',
      'Soporte Técnico L1/L2 IT',
      'Encargado Comercial',
      'Desarrollador Full Stack Web y Mobile',
    ],
    address: { '@type': 'PostalAddress', addressCountry: 'EC' },
    sameAs: SOCIAL.map((s) => s.href),
    knowsAbout: [
      'Flutter',
      'Dart',
      'Firebase',
      'Soporte técnico L1/L2',
      'Helpdesk',
      'Desarrollo web',
      'Productos digitales',
    ],
  },
];
