/// Catálogo del blog (copia de contenido Tinguar; fuentes en assets/blog/).
class BlogPost {
  final String slug;
  final String title;
  final String excerpt;
  final String? excerptEn;
  final String author;
  final String date;
  final String dateLabel;
  final List<String> categories;
  final List<String> tags;
  final String imageAsset;
  final String readTime;
  final bool featured;
  final String assetPath;

  const BlogPost({
    required this.slug,
    required this.title,
    required this.excerpt,
    this.excerptEn,
    required this.author,
    required this.date,
    required this.dateLabel,
    required this.categories,
    required this.tags,
    required this.imageAsset,
    required this.readTime,
    required this.featured,
    required this.assetPath,
  });

  String get route => '/blog/$slug';

  String localizedExcerpt(bool isEnglish) {
    if (isEnglish && excerptEn != null && excerptEn!.isNotEmpty) {
      return excerptEn!;
    }
    return excerpt;
  }
}

const List<BlogPost> infoBlogPosts = [
  BlogPost(
    slug: "flutter-arquitectura-por-capas",
    title:
        "Arquitectura Flutter por capas: ordena tu proyecto sin pelearte con el caos",
    excerpt:
        "Cómo organizar un proyecto Flutter en capas (Data, Domain, UI, Core y Routes): carpetas, responsabilidades y un flujo claro de punta a punta.",
    excerptEn: "How to structure a Flutter app in layers (Data, Domain, UI, Core, Routes) with a clear end-to-end flow.",
    author: "Alberto Guaman",
    date: "2026-07-29",
    dateLabel: "julio 29, 2026",
    categories: ["Flutter", "Arquitectura", "Dart", "Tutorial"],
    tags: [
      "flutter",
      "arquitectura",
      "capas",
      "clean-architecture",
      "getx",
      "dart",
      "estructura",
      "escalabilidad"
    ],
    imageAsset: "assets/blog/images/flutter-arquitectura-por-capas.jpg",
    readTime: "10 min",
    featured: true,
    assetPath: "assets/blog/posts/flutter-arquitectura-por-capas.md",
  ),
  BlogPost(
    slug: "zimaos-uptime-kuma-app-store",
    title:
        "Uptime Kuma en ZimaOS: instálalo desde la App Store y monitorea tus servicios",
    excerpt:
        "Qué es Uptime Kuma, cómo instalarlo desde la App Store de ZimaOS y cómo recibir alertas (incluido un extra con bot de Telegram) sin vivir pegado al panel.",
    excerptEn: "Install Uptime Kuma on ZimaOS from the App Store and monitor your services with alerts.",
    author: "Alberto Guaman",
    date: "2026-07-28",
    dateLabel: "julio 28, 2026",
    categories: ["Linux", "Servidores", "Homelab", "Tutorial", "Monitoreo"],
    tags: [
      "zimaos",
      "uptime-kuma",
      "monitoreo",
      "docker",
      "mini-pc",
      "app-store",
      "servidor-personal"
    ],
    imageAsset: "assets/blog/images/zimaos-uptime-kuma-app-store.jpg",
    readTime: "11 min",
    featured: true,
    assetPath: "assets/blog/posts/zimaos-uptime-kuma-app-store.md",
  ),
  BlogPost(
    slug: "zimaos-astro-docker-hosting",
    title: "Hospedar Astro o Vue en ZimaOS con Docker y Cloudflare Tunnel",
    excerpt:
        "Proceso real: build estático, Nginx en Docker, docker-compose en ZimaOS y dominio público con Cloudflare Tunnel sin abrir puertos.",
    excerptEn: "Host Astro or Vue on ZimaOS with Docker, Nginx and Cloudflare Tunnel.",
    author: "Alberto Guaman",
    date: "2026-07-21",
    dateLabel: "julio 21, 2026",
    categories: ["Linux", "Servidores", "NAS", "Astro", "Tutorial"],
    tags: [
      "zimaos",
      "astro",
      "vue",
      "docker",
      "nginx",
      "cloudflare",
      "tunnels",
      "hosting",
      "despliegue"
    ],
    imageAsset: "assets/blog/images/zimaos-astro-docker-hosting.jpg",
    readTime: "14 min",
    featured: true,
    assetPath: "assets/blog/posts/zimaos-astro-docker-hosting.md",
  ),
  BlogPost(
    slug: "zimaos-cloudflare-tunnels",
    title: "ZimaOS y Cloudflare Tunnels: expón tu NAS sin abrir puertos",
    excerpt:
        "Cómo usar Cloudflare Tunnels con ZimaOS para acceder a tu servidor desde fuera sin reenvío de puertos ni exponer la red de casa.",
    excerptEn: "Expose your NAS securely with ZimaOS and Cloudflare Tunnels—no open ports.",
    author: "Alberto Guaman",
    date: "2026-07-14",
    dateLabel: "julio 14, 2026",
    categories: ["Linux", "Servidores", "NAS", "Seguridad", "Tutorial"],
    tags: ["zimaos", "cloudflare", "tunnels", "nas", "seguridad"],
    imageAsset: "assets/blog/images/zimaos-cloudflare-tunnels.jpg",
    readTime: "8 min",
    featured: true,
    assetPath: "assets/blog/posts/zimaos-cloudflare-tunnels.md",
  ),
  BlogPost(
    slug: "zimaos-servidor-personal-nas",
    title: "ZimaOS: un NAS en casa sin pelearte tanto con Linux",
    excerpt:
        "Qué es ZimaOS, para qué sirve y qué puedes correr en tu propio servidor: archivos, multimedia, Docker, IA local y más.",
    excerptEn: "ZimaOS as a home NAS without fighting Linux every day.",
    author: "Alberto Guaman",
    date: "2026-07-10",
    dateLabel: "julio 10, 2026",
    categories: ["Linux", "Servidores", "NAS", "Tutorial"],
    tags: ["zimaos", "nas", "docker", "servidor-personal", "nube-privada"],
    imageAsset: "assets/blog/images/zimaos-servidor-personal-nas.jpg",
    readTime: "7 min",
    featured: false,
    assetPath: "assets/blog/posts/zimaos-servidor-personal-nas.md",
  ),
  BlogPost(
    slug: "como-usar-calculadora-porcentaje-tarjeta",
    title: "Cómo usar la calculadora de porcentaje por tarjeta",
    excerpt:
        "Guía paso a paso para usar la herramienta de porcentaje por tarjeta en tinguar.com: ingresar montos, ver precios con financiamiento (corriente, débito, cuotas) y generar proformas para tus clientes.",
    author: "Alberto Guaman",
    date: "2026-01-23",
    dateLabel: "enero 23, 2026",
    categories: ["Herramientas", "Finanzas", "Tutorial", "Web"],
    tags: [
      "calculadora",
      "porcentaje-tarjeta",
      "proforma",
      "financiamiento",
      "cuotas",
      "tinguar",
      "tutorial",
      "herramienta"
    ],
    imageAsset:
        "assets/blog/images/como-usar-calculadora-porcentaje-tarjeta.png",
    readTime: "6 min",
    featured: true,
    assetPath: "assets/blog/posts/como-usar-calculadora-porcentaje-tarjeta.md",
  ),
  BlogPost(
    slug: "paywall-js-introduccion",
    title:
        "Paywall.js: La Librería JavaScript para Crear Paywalls Inteligentes",
    excerpt:
        "Descubre Paywall.js, una librería JavaScript que te permite crear paywalls dinámicos y efectivos para tu sitio web. Aprende cómo implementar restricciones de acceso basadas en fechas de vencimiento.",
    author: "alberto guaman",
    date: "2025-07-20",
    dateLabel: "julio 20, 2025",
    categories: [
      "JavaScript",
      "Paywall",
      "Librerías",
      "Frontend",
      "Web Development"
    ],
    tags: [
      "javascript",
      "paywall",
      "librerias",
      "frontend",
      "web-development",
      "contenido-premium",
      "restricciones",
      "tutorial"
    ],
    imageAsset: "assets/blog/images/paywall-js-introduccion.jpg",
    readTime: "15 min",
    featured: true,
    assetPath: "assets/blog/posts/paywall-js-introduccion.md",
  ),
  BlogPost(
    slug: "sql-basico",
    title:
        "SQL Básico: Lo Esencial que Todo Principiante Debe Saber para Dominar las Bases de Datos",
    excerpt:
        "Descubre los fundamentos de SQL con ejemplos claros y prácticos. Aprende los comandos esenciales y buenas prácticas para empezar a dominar las bases de datos relacionales.",
    author: "Alberto Guaman",
    date: "2025-07-07",
    dateLabel: "julio 7, 2025",
    categories: ["SQL", "Bases de Datos", "Programacion"],
    tags: [
      "sql",
      "bases-de-datos",
      "programacion",
      "tutorial",
      "principiante",
      "consultas",
      "mysql",
      "postgresql"
    ],
    imageAsset: "assets/blog/images/sql-basico.jpg",
    readTime: "15 min",
    featured: false,
    assetPath: "assets/blog/posts/sql-basico.md",
  ),
  BlogPost(
    slug: "generar-imagenes-de-modelos-de-ropa-con-ia",
    title: "Generar Imágenes de Modelos de Ropa con IA",
    excerpt:
        "Descubre cómo crear imágenes de modelos de ropa realistas usando Inteligencia Artificial. Te mostramos dos métodos: con imagen de referencia y con descripción detallada en texto.",
    author: "alberto guaman",
    date: "2025-01-27",
    dateLabel: "enero 27, 2025",
    categories: ["Moda", "IA", "Diseño", "Tutorial", "Inteligencia Artificial"],
    tags: [
      "moda",
      "inteligencia-artificial",
      "modelos",
      "imagen-referencia",
      "descripcion-texto",
      "diseño",
      "ecommerce",
      "prompts",
      "ia"
    ],
    imageAsset:
        "assets/blog/images/generar-imagenes-de-modelos-de-ropa-con-ia-introduccion.jpg",
    readTime: "10 min",
    featured: true,
    assetPath:
        "assets/blog/posts/generar-imagenes-de-modelos-de-ropa-con-ia.md",
  ),
  BlogPost(
    slug: "paywall-flutter",
    title: "Paywall Flutter: Crea Paywalls en Flutter en 5 Minutos",
    excerpt:
        "Descubre Paywall Flutter, un widget simple que te permite crear paywalls en tu app Flutter en solo 5 minutos. Aprende a implementar restricciones de contenido basadas en fechas de vencimiento.",
    excerptEn: "Create Flutter paywalls quickly with a practical paywall approach.",
    author: "alberto guaman",
    date: "2025-01-27",
    dateLabel: "enero 27, 2025",
    categories: ["Flutter", "Paywall", "Widget", "Mobile", "Desarrollo Móvil"],
    tags: [
      "flutter",
      "paywall",
      "widget",
      "desarrollo-movil",
      "dart",
      "tutorial",
      "contenido-premium",
      "suscripciones"
    ],
    imageAsset: "assets/blog/images/paywall-flutter.jpg",
    readTime: "5 min",
    featured: true,
    assetPath: "assets/blog/posts/paywall-flutter.md",
  ),
  BlogPost(
    slug: "introduccion-lit-html",
    title: "Introducción a Lit HTML: Creando Interfaces Web Modernas",
    excerpt:
        "Descubre Lit HTML, una librería ligera de Google para crear componentes web reutilizables. Aprende a construir interfaces modernas y eficientes con esta tecnología del futuro.",
    author: "Alberto Guaman",
    date: "2025-01-15",
    dateLabel: "enero 15, 2025",
    categories: ["Lit HTML", "Web Components", "JavaScript", "Frontend"],
    tags: [
      "lit-html",
      "web-components",
      "javascript",
      "frontend",
      "google",
      "interfaces",
      "componentes",
      "tutorial"
    ],
    imageAsset:
        "assets/blog/images/introduccion-a-lit-html-creando-interfaces-web-modernas.jpg",
    readTime: "12 min",
    featured: false,
    assetPath: "assets/blog/posts/introduccion-lit-html.md",
  ),
  BlogPost(
    slug: "introduccion-paradigmas-dart",
    title: "Introducción a los Paradigmas de Programación con Dart",
    excerpt:
        "Explora los diferentes paradigmas de programación usando Dart como lenguaje. Desde programación orientada a objetos hasta programación funcional, descubre cómo Dart implementa cada enfoque.",
    author: "Alberto Guaman",
    date: "2025-01-10",
    dateLabel: "enero 10, 2025",
    categories: ["Dart", "Paradigmas", "Programación", "Flutter"],
    tags: [
      "dart",
      "paradigmas",
      "programacion",
      "flutter",
      "orientado-objetos",
      "funcional",
      "tutorial",
      "fundamentos"
    ],
    imageAsset:
        "assets/blog/images/introduccion-a-los-paradigmas-de-programacion-con-dart.jpg",
    readTime: "8 min",
    featured: false,
    assetPath: "assets/blog/posts/introduccion-paradigmas-dart.md",
  ),
  BlogPost(
    slug: "javascript-tipos",
    title:
        "Guía Completa de Tipos de Datos en JavaScript: Cómo y Cuándo Utilizarlos",
    excerpt:
        "Domina los tipos de datos en JavaScript con esta guía completa. Aprende sobre primitivos, objetos, arrays y cuándo usar cada uno para escribir código más robusto y eficiente.",
    author: "Alberto Guaman",
    date: "2025-01-08",
    dateLabel: "enero 8, 2025",
    categories: ["JavaScript", "Tipos de Datos", "Programación", "Frontend"],
    tags: [
      "javascript",
      "tipos-datos",
      "programacion",
      "frontend",
      "primitivos",
      "objetos",
      "arrays",
      "tutorial",
      "fundamentos"
    ],
    imageAsset:
        "assets/blog/images/guia-completa-de-tipos-de-datos-en-javascript-como-y-cuando-utilizarlos.jpg",
    readTime: "10 min",
    featured: false,
    assetPath: "assets/blog/posts/javascript-tipos.md",
  ),
  BlogPost(
    slug: "lazyvim-transparent",
    title:
        "Cómo Activar el Modo Transparente en LazyVim y Personalizar tu Terminal XFCE",
    excerpt:
        "Aprende a configurar LazyVim con transparencia y personaliza tu terminal XFCE para una experiencia de desarrollo más atractiva y profesional.",
    author: "Alberto Guaman",
    date: "2025-01-05",
    dateLabel: "enero 5, 2025",
    categories: ["LazyVim", "Neovim", "Terminal", "XFCE", "Personalización"],
    tags: [
      "lazyvim",
      "neovim",
      "terminal",
      "xfce",
      "personalizacion",
      "transparencia",
      "vim",
      "editor",
      "tutorial"
    ],
    imageAsset:
        "assets/blog/images/como-activar-el-modo-transparente-en-lazyvim-y-personalizar-tu-terminal-xfce.jpg",
    readTime: "8 min",
    featured: false,
    assetPath: "assets/blog/posts/lazyvim-transparent.md",
  ),
  BlogPost(
    slug: "git-repositorio",
    title: "Cómo Iniciar un Repositorio en Git: Una Guía Paso a Paso",
    excerpt:
        "Aprende a crear y configurar tu primer repositorio Git desde cero. Desde la inicialización hasta el primer commit, te guiamos en todo el proceso.",
    author: "Alberto Guaman",
    date: "2025-01-03",
    dateLabel: "enero 3, 2025",
    categories: ["Git", "Control de Versiones", "Desarrollo", "Tutorial"],
    tags: [
      "git",
      "control-versiones",
      "desarrollo",
      "tutorial",
      "repositorio",
      "commit",
      "github",
      "principiante"
    ],
    imageAsset:
        "assets/blog/images/como-iniciar-un-repositorio-en-git-una-guia-paso-a-paso.jpg",
    readTime: "6 min",
    featured: false,
    assetPath: "assets/blog/posts/git-repositorio.md",
  ),
  BlogPost(
    slug: "introduccion-astro",
    title: "Introducción a Astro: El Framework Web del Futuro",
    excerpt:
        "Descubre Astro, el framework web que está revolucionando el desarrollo frontend. Aprende sus características únicas y por qué es la elección perfecta para sitios web modernos.",
    excerptEn: "Introduction to Astro: a modern web framework for fast content sites.",
    author: "Alberto Guaman",
    date: "2025-01-01",
    dateLabel: "enero 1, 2025",
    categories: ["Astro", "Framework", "Web Development", "Frontend"],
    tags: [
      "astro",
      "framework",
      "web-development",
      "frontend",
      "ssg",
      "componentes",
      "tutorial",
      "moderno"
    ],
    imageAsset:
        "assets/blog/images/introduccion-a-astro-el-framework-web-del-futuro.jpg",
    readTime: "10 min",
    featured: false,
    assetPath: "assets/blog/posts/introduccion-astro.md",
  ),
  BlogPost(
    slug: "flutter-provider",
    title: "Manejando Estados con Flutter Utilizando Provider",
    excerpt:
        "Aprende a gestionar el estado de tu aplicación Flutter de manera eficiente usando Provider. Descubre patrones de diseño y mejores prácticas para aplicaciones escalables.",
    author: "Alberto Guaman",
    date: "2024-12-28",
    dateLabel: "diciembre 28, 2024",
    categories: ["Flutter", "Provider", "Estado", "Desarrollo Móvil"],
    tags: [
      "flutter",
      "provider",
      "estado",
      "desarrollo-movil",
      "dart",
      "patrones",
      "tutorial",
      "gestion-estado"
    ],
    imageAsset:
        "assets/blog/images/manejando-estados-con-flutter-utilizando-provider.jpg",
    readTime: "12 min",
    featured: false,
    assetPath: "assets/blog/posts/flutter-provider.md",
  ),
  BlogPost(
    slug: "flutter-responsive",
    title: "Escalabilidad de Texto Responsivo en Flutter",
    excerpt:
        "Descubre cómo crear aplicaciones Flutter que se adapten perfectamente a diferentes tamaños de pantalla. Aprende técnicas de diseño responsivo para una experiencia de usuario óptima.",
    author: "Alberto Guaman",
    date: "2024-12-25",
    dateLabel: "diciembre 25, 2024",
    categories: ["Flutter", "Responsive", "UI", "Desarrollo Móvil"],
    tags: [
      "flutter",
      "responsive",
      "ui",
      "desarrollo-movil",
      "dart",
      "escalabilidad",
      "tutorial",
      "diseño-adaptativo"
    ],
    imageAsset:
        "assets/blog/images/escalabilidad-de-texto-responsivo-en-flutter.jpg",
    readTime: "8 min",
    featured: false,
    assetPath: "assets/blog/posts/flutter-responsive.md",
  ),
  BlogPost(
    slug: "flutter-enum",
    title: "Guía Completa sobre Enum y Enum Avanzados en Flutter",
    excerpt:
        "Domina el uso de enumeraciones en Flutter y Dart. Desde conceptos básicos hasta técnicas avanzadas, aprende a crear código más limpio y mantenible.",
    author: "Alberto Guaman",
    date: "2024-12-22",
    dateLabel: "diciembre 22, 2024",
    categories: ["Flutter", "Enum", "Dart", "Programación"],
    tags: [
      "flutter",
      "enum",
      "dart",
      "programacion",
      "enumeraciones",
      "tutorial",
      "codigo-limpio",
      "fundamentos"
    ],
    imageAsset:
        "assets/blog/images/guia-completa-sobre-enum-y-enum-avanzados-en-flutter.jpg",
    readTime: "10 min",
    featured: false,
    assetPath: "assets/blog/posts/flutter-enum.md",
  ),
  BlogPost(
    slug: "astro-github-pages",
    title: "Guía para Crear y Desplegar una Página con Astro en GitHub Pages",
    excerpt:
        "Aprende paso a paso cómo crear un sitio web con Astro y publicarlo gratis en GitHub Pages. Ideal para portafolios, blogs y proyectos personales.",
    author: "Alberto Guaman",
    date: "2024-12-21",
    dateLabel: "diciembre 21, 2024",
    categories: ["Astro", "GitHub Pages", "Despliegue", "Web"],
    tags: ["astro", "github-pages", "despliegue", "web", "tutorial", "gratis"],
    imageAsset:
        "assets/blog/images/guia-para-crear-y-desplegar-una-pagina-con-astro-en-github-pages.jpg",
    readTime: "10 min",
    featured: false,
    assetPath: "assets/blog/posts/astro-github-pages.md",
  ),
  BlogPost(
    slug: "flutter-firebase",
    title: "Cómo Desplegar tu Sitio Flutter Web en Firebase Hosting",
    excerpt:
        "Guía completa para desplegar tu aplicación Flutter Web en Firebase Hosting. Desde la configuración hasta el despliegue, aprende a publicar tu app en la nube de Google.",
    author: "Alberto Guaman",
    date: "2024-12-19",
    dateLabel: "diciembre 19, 2024",
    categories: ["Flutter", "Firebase", "Hosting", "Despliegue"],
    tags: [
      "flutter",
      "firebase",
      "hosting",
      "despliegue",
      "web",
      "google",
      "tutorial",
      "cloud"
    ],
    imageAsset:
        "assets/blog/images/como-desplegar-tu-sitio-flutter-web-en-firebase-hosting.jpg",
    readTime: "8 min",
    featured: false,
    assetPath: "assets/blog/posts/flutter-firebase.md",
  ),
  BlogPost(
    slug: "dart-fundamentos",
    title: "Guía Completa de Dart: Fundamentos y Ejemplos Prácticos",
    excerpt:
        "Aprende Dart desde cero con esta guía completa. Desde sintaxis básica hasta conceptos avanzados, domina el lenguaje que impulsa Flutter.",
    author: "Alberto Guaman",
    date: "2024-12-16",
    dateLabel: "diciembre 16, 2024",
    categories: ["Dart", "Programación", "Flutter", "Fundamentos"],
    tags: [
      "dart",
      "programacion",
      "flutter",
      "fundamentos",
      "sintaxis",
      "tutorial",
      "lenguaje",
      "principiante"
    ],
    imageAsset:
        "assets/blog/images/guia-completa-de-dart-fundamentos-y-ejemplos-practicos.jpg",
    readTime: "15 min",
    featured: false,
    assetPath: "assets/blog/posts/dart-fundamentos.md",
  ),
  BlogPost(
    slug: "flutter-dark-mode",
    title: "Alterna entre Modo Oscuro y Claro en Flutter",
    excerpt:
        "Aprende cómo implementar el modo oscuro y claro en tus aplicaciones Flutter de forma sencilla y profesional. Incluye ejemplos prácticos y consejos de diseño.",
    author: "Alberto Guaman",
    date: "2024-12-16",
    dateLabel: "diciembre 16, 2024",
    categories: ["Flutter", "Dark Mode", "UI", "Desarrollo Móvil"],
    tags: [
      "flutter",
      "dark-mode",
      "ui",
      "desarrollo-movil",
      "tema",
      "accesibilidad",
      "dart"
    ],
    imageAsset:
        "assets/blog/images/alterna-entre-modo-oscuro-y-claro-en-flutter.jpg",
    readTime: "8 min",
    featured: false,
    assetPath: "assets/blog/posts/flutter-dark-mode.md",
  ),
  BlogPost(
    slug: "dom-optimizacion",
    title: "Optimiza el DOM: Manipulación Eficiente sin Sacrificar Rendimiento",
    excerpt:
        "Descubre técnicas avanzadas para optimizar la manipulación del DOM en JavaScript. Aprende a crear aplicaciones web más rápidas y responsivas.",
    author: "Alberto Guaman",
    date: "2024-12-13",
    dateLabel: "diciembre 13, 2024",
    categories: ["JavaScript", "DOM", "Optimización", "Performance"],
    tags: [
      "javascript",
      "dom",
      "optimizacion",
      "performance",
      "web",
      "manipulacion",
      "tutorial",
      "rendimiento"
    ],
    imageAsset:
        "assets/blog/images/optimiza-el-dom-manipulacion-eficiente-sin-sacrificar-rendimiento.jpg",
    readTime: "12 min",
    featured: false,
    assetPath: "assets/blog/posts/dom-optimizacion.md",
  ),
  BlogPost(
    slug: "blog-python-pelican",
    title:
        "Crea tu Blog de Calidad con Python y Pelican: Guía Completa para Principiantes",
    excerpt:
        "Aprende a crear un blog profesional usando Python y Pelican. Desde la instalación hasta el despliegue, construye tu presencia online con herramientas gratuitas y poderosas.",
    author: "Alberto Guaman",
    date: "2024-12-10",
    dateLabel: "diciembre 10, 2024",
    categories: ["Python", "Pelican", "Blog", "Desarrollo Web"],
    tags: [
      "python",
      "pelican",
      "blog",
      "desarrollo-web",
      "static-site",
      "tutorial",
      "principiante",
      "gratis"
    ],
    imageAsset:
        "assets/blog/images/crea-tu-blog-de-calidad-con-python-y-pelican-guia-completa-para-principiantes.jpg",
    readTime: "15 min",
    featured: false,
    assetPath: "assets/blog/posts/blog-python-pelican.md",
  ),
  BlogPost(
    slug: "codigos-http",
    title:
        "Códigos de Estado HTTP: Más Allá del 404, Todo lo que Necesitas Saber",
    excerpt:
        "Domina los códigos de estado HTTP con esta guía completa. Desde respuestas exitosas hasta errores del servidor, entiende cómo funciona la comunicación web.",
    excerptEn: "HTTP status codes beyond 404: what developers need to know day to day.",
    author: "Alberto Guaman",
    date: "2024-12-07",
    dateLabel: "diciembre 7, 2024",
    categories: ["HTTP", "Web Development", "API", "Protocolos"],
    tags: [
      "http",
      "web-development",
      "api",
      "protocolos",
      "codigos-estado",
      "tutorial",
      "fundamentos",
      "web"
    ],
    imageAsset:
        "assets/blog/images/codigos-de-estado-http-mas-alla-del-404-todo-lo-que-necesitas-saber.jpg",
    readTime: "10 min",
    featured: false,
    assetPath: "assets/blog/posts/codigos-http.md",
  ),
];

BlogPost? blogPostBySlug(String slug) {
  for (final post in infoBlogPosts) {
    if (post.slug == slug) return post;
  }
  return null;
}
