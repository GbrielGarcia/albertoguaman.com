class ChangelogEntry {
  final String date;
  final String title;
  final List<String> items;

  const ChangelogEntry({
    required this.date,
    required this.title,
    required this.items,
  });
}

const List<ChangelogEntry> infoChangelog = [
  ChangelogEntry(
    date: 'Septiembre 2026',
    title: 'Lo que faltaba para cerrar el ciclo',
    items: [
      'Armé /servicios con lo que ya ofrezco (soporte, Flutter, web, e-commerce).',
      'Dejé por escrito cómo trabajo: FAQ, disponibilidad y stack al clic.',
      'En /casos metí antes/después y números concretos, no solo el relato.',
      'Saqué el inglés del sitio. Si alguien entra, que lea en español y punto.',
      'Arreglé el amarillo en tema claro: se veía horrible.',
    ],
  ),
  ChangelogEntry(
    date: 'Marzo 2025',
    title: 'Cuando el portafolio se volvió sitio de verdad',
    items: [
      'Subí blog, casos, recomendaciones y una vista de CV.',
      'Header fijo, splash y el año de fondo: detalles que noté que faltaban.',
      'Hostinger me rompía /blog y /cv; lo dejé resuelto en el .htaccess.',
    ],
  ),
  ChangelogEntry(
    date: 'Junio 2023',
    title: 'Más contenido, menos “landing vacía”',
    items: [
      'Agregué proyectos y clientes para que se vea qué he hecho.',
      'Contacto y galería: lo básico para que alguien te escriba.',
      'Títulos y descripciones por ruta para que Google no vea una sola página.',
    ],
  ),
  ChangelogEntry(
    date: '2020',
    title: 'Arranque',
    items: [
      'Primera versión de albertoguaman.com. Nada fancy: perfil, experiencia y skills.',
      'Desde ahí lo vengo tocando cada vez que el portafolio se me queda corto.',
    ],
  ),
];
