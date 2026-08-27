// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// enum ContentSource { blog, linkedin, instagram }

// class ContentPost {
//   final String title;
//   final String excerpt;
//   final String url;
//   final String dateLabel;
//   final ContentSource source;
//   final List<String> tags;

//   const ContentPost({
//     required this.title,
//     required this.excerpt,
//     required this.url,
//     required this.dateLabel,
//     required this.source,
//     this.tags = const [],
//   });

//   String get sourceLabel {
//     switch (source) {
//       case ContentSource.blog:
//         return 'Blog Tinguar';
//       case ContentSource.linkedin:
//         return 'LinkedIn';
//       case ContentSource.instagram:
//         return 'Instagram';
//     }
//   }

//   IconData get sourceIcon {
//     switch (source) {
//       case ContentSource.blog:
//         return FontAwesomeIcons.rss;
//       case ContentSource.linkedin:
//         return FontAwesomeIcons.linkedin;
//       case ContentSource.instagram:
//         return FontAwesomeIcons.instagram;
//     }
//   }
// }

// /// Contenido curado: blog (artículos reales) + perfiles sociales.
// /// LinkedIn/Instagram no exponen feed público sin API; se enlazan perfiles
// /// y piezas destacadas editables aquí.
// List<ContentPost> infoContentPostModel = [
//   ContentPost(
//     title: 'Arquitectura Flutter por capas',
//     excerpt:
//         'Cómo organizar un proyecto Flutter en capas (Data, Domain, UI, Core y Routes) sin pelearte con el caos.',
//     url: 'https://tinguar.com/blog/flutter-arquitectura-por-capas',
//     dateLabel: 'Jul 2026',
//     source: ContentSource.blog,
//     tags: ['Flutter', 'Arquitectura'],
//   ),
//   ContentPost(
//     title: 'Uptime Kuma en ZimaOS',
//     excerpt:
//         'Instálalo desde la App Store, monitorea servicios y recibe alertas (incluye tip con bot de Telegram).',
//     url: 'https://tinguar.com/blog/zimaos-uptime-kuma-app-store',
//     dateLabel: 'Jul 2026',
//     source: ContentSource.blog,
//     tags: ['Linux', 'ZimaOS'],
//   ),
//   ContentPost(
//     title: 'Hospedar Astro o Vue en ZimaOS',
//     excerpt:
//         'Build estático, Nginx en Docker, docker-compose y dominio público con Cloudflare Tunnel.',
//     url: 'https://tinguar.com/blog/zimaos-astro-docker-hosting',
//     dateLabel: 'Jul 2026',
//     source: ContentSource.blog,
//     tags: ['Docker', 'Hosting'],
//   ),
//   ContentPost(
//     title: 'ZimaOS y Cloudflare Tunnels',
//     excerpt:
//         'Expón tu NAS sin abrir puertos: acceso externo seguro sin reenvío de puertos.',
//     url: 'https://tinguar.com/blog/zimaos-cloudflare-tunnels',
//     dateLabel: 'Jul 2026',
//     source: ContentSource.blog,
//     tags: ['ZimaOS', 'Cloudflare'],
//   ),
//   ContentPost(
//     title: 'Actualizaciones profesionales en LinkedIn',
//     excerpt:
//         'Experiencia, proyectos y reflexiones técnicas. Sígueme para ver lo último publicado.',
//     url: 'https://www.linkedin.com/in/albertoguaman',
//     dateLabel: 'Perfil',
//     source: ContentSource.linkedin,
//     tags: ['Carrera', 'Red'],
//   ),
//   ContentPost(
//     title: '@albertoguamandev en Instagram',
//     excerpt:
//         'Detrás de escena de desarrollo, producto y día a día tech. Contenido visual y tips cortos.',
//     url: 'https://www.instagram.com/albertoguamandev/',
//     dateLabel: 'Perfil',
//     source: ContentSource.instagram,
//     tags: ['Dev', 'Visual'],
//   ),
// ];
