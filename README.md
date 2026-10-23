# albertoguaman.com

Blog y portafolio de Alberto Guaman, hecho con [Astro](https://astro.build). Genera HTML estático que se publica en Hostinger (Apache).

> Hasta octubre de 2026 el sitio era una app Flutter web. El último commit con ese código es `e8d705b`. La migración está documentada en [`docs/migracion-astro.md`](docs/migracion-astro.md).

## Desarrollo

```sh
npm install
npm run dev          # http://localhost:4321
npm run check        # tipos y errores de Astro
npm run build        # genera dist/
npm run preview      # sirve dist/ en local
```

Requiere Node 22.23.4 o superior (en CI se usa Node 24).

## Escribir un post

1. Crea `src/content/blog/<slug>.md`. El nombre del archivo es la URL: `/blog/<slug>`.
2. Pon la portada en `src/content/blog/images/` y enlázala con una ruta relativa.

```md
---
title: "Título del artículo"
excerpt: "Resumen de una o dos frases (sale en Google y en las tarjetas)."
date: "2026-10-22"
categories: ["Flutter", "Tutorial"]
tags: ["flutter", "dart"]
image: ./images/mi-portada.jpg
readTime: "8 min"
featured: false
---

Contenido en Markdown…
```

Las categorías deciden en qué tema aparece el post (`/blog/categoria/<tema>`). Los temas y sus palabras clave están en `src/data/blog.ts`. Con `draft: true` el post solo se ve con `npm run dev`.

## Estructura

| Ruta | Qué hay |
|---|---|
| `src/content/blog/` | Posts en Markdown e imágenes |
| `src/data/site.ts` | Nombre, navegación, SEO por página, AdSense |
| `src/data/profile.ts` | Perfil, experiencia, herramientas, proyectos, publicaciones |
| `src/data/work.ts` | Servicios, casos, reseñas, FAQ, changelog |
| `src/pages/` | Una página por URL |
| `src/layouts/PostLayout.astro` | Página de cada post (estructura tipo tinguar.com) |
| `src/components/vue/` | Islas interactivas: galería y stack |
| `public/` | Archivos con URL fija: `/cv/*.pdf`, `ads.txt`, `.htaccess`, `robots.txt` |

## Anuncios (AdSense)

- El script de AdSense (`ca-pub-1686355120044737`) se carga en todas las páginas del build de producción, excepto la 404. Con eso funcionan los **anuncios automáticos** que actives en AdSense.
- Para bloques fijos, crea un bloque en AdSense (Anuncios → Por bloque de anuncios) y pega su ID en `SITE.adSlots` (`src/data/site.ts`). En los posts hay tres posiciones: antes del contenido (`postTop`), al final (`postBottom`) y en la barra lateral (`postAside`). Si el ID está vacío, ese bloque no se muestra.
- El aviso de consentimiento para la UE y el Reino Unido se activa desde AdSense (Privacidad y mensajes); no necesita código.

## Publicar en Hostinger

```sh
npm run build
```

1. Sube **todo el contenido** de `dist/` a `public_html/`, incluido el archivo oculto `.htaccess`, y reemplaza lo anterior. Borra antes los restos del sitio Flutter (`main.dart.js`, `flutter*.js`, `canvaskit/`, `assets/`).
2. Comprueba que todo responde bien:

```sh
npm run check:urls -- https://albertoguaman.com
```

El script revisa las 38 URLs que ya estaban en Google, las redirecciones y los 404/410. Debe terminar en `✓ 55 URLs correctas`.

### Cómo se sirven las URLs

Astro genera `blog.html`, `blog/<slug>.html`, etc. (`build.format: 'file'`). El `.htaccess` de `public/` las sirve sin `.html` ni barra final (`/blog/<slug>`), que es como estaban indexadas. Además:

- Redirige `/sitemap.xml` a `/sitemap-index.xml`.
- Responde 410 en `/nosotros`, `/flores-amarillas` y los archivos de Flutter.
- Usa la página `404.html` para cualquier ruta que no exista.
