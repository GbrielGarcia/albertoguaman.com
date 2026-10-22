# Plan de migración: Flutter web → Astro

Objetivo: convertir albertoguaman.com en un sitio de contenido general, rápido, indexable y listo para AdSense, **sin perder ninguna URL ya indexada**.

> **Decisión (22 oct 2026):** el sitio Flutter queda congelado: no se le harán más cambios y será reemplazado por completo por el sitio Astro. El código Flutter se conserva en el repo **solo como fuente de datos** (textos de `lib/src/model/`, imágenes de `assets/`, PDFs del CV) hasta terminar las fases 3 y 4. Después se borra (fase 6).
>
> Hasta el día del cambio, lo que está en línea sigue siendo el build Flutter.

Estado actual (oct 2026):

- Flutter web (go_router, `usePathUrlStrategy`), ~14k líneas de Dart, solo español.
- Hosting: Hostinger (Apache), con un `.htaccess` que manda todas las rutas a `index.html`.
- 26 posts en `assets/blog/posts/*.md`, que ya tienen frontmatter, más 29 imágenes en `assets/blog/images/`.
- Los metadatos del blog están **duplicados** en `lib/src/model/blog_post.dart` (slug, `featured`, `excerptEn`, `imageAsset`).
- Datos de las páginas en `lib/src/model/*.dart`: experiencia, skills, casos, servicios, FAQ, testimonios, changelog, galería.
- Archivos públicos que hay que conservar: `/cv/*.pdf`, `/blog/rss.xml`, `/sitemap.xml`, `/robots.txt`, `/og-image.png`, `/audio/flores-amarillas.mp3`, `/stickers/`, `/icons/`.

---

## 1. Inventario de URLs (todas deben seguir respondiendo 200)

| URL actual | Origen en Flutter | Destino en Astro |
|---|---|---|
| `/` | `home.dart` | `src/pages/index.astro` |
| `/bio` | `home/bio.dart` | `src/pages/bio.astro` |
| `/blog` | `blog_list_page.dart` | `src/pages/blog/index.astro` |
| `/blog/<slug>` (26) | `blog_detail_page.dart` | `src/pages/blog/[slug].astro` |
| `/blog/rss.xml` | `tool/generate_rss.py` | `src/pages/blog/rss.xml.ts` (`@astrojs/rss`) |
| `/galeria` | `gallery_page.dart` | `src/pages/galeria.astro` |
| `/contacto` | `contact_page.dart` | `src/pages/contacto.astro` |
| `/casos` | `case_studies_page.dart` | `src/pages/casos.astro` |
| `/recomendaciones` | `recommendations_page.dart` | `src/pages/recomendaciones.astro` |
| `/cv` | `cv/cv_page.dart` | `src/pages/cv.astro` |
| `/cv/*.pdf` | `web/cv/` | `public/cv/` (se copian tal cual) |
| `/servicios` | `services_page.dart` | `src/pages/servicios.astro` |
| `/faq` | `faq_page.dart` | `src/pages/faq.astro` |
| `/changelog` | `changelog_page.dart` | `src/pages/changelog.astro` |
| `/flores-amarillas` | `flores_amarillas/` | `src/pages/flores-amarillas.astro` (`noindex`) |
| `/nosotros` | `nosotros/` | `src/pages/nosotros.astro` (`noindex`) |

URLs que hoy sirve Flutter y que pueden aparecer en Google Imágenes o en enlaces externos:

| URL antigua | Acción |
|---|---|
| `/assets/assets/blog/images/<img>.jpg` | 301 → `/blog` (las imágenes ahora tienen nombre con hash en `/_astro/`) |
| `/assets/assets/img/...` | 301 a la nueva ruta si la imagen sigue existiendo; si no, dejar que dé 404 |
| `/main.dart.js`, `/flutter.js`, `/canvaskit/*` | Dejar que den 404 (no tienen valor SEO) |

Nuevas URLs que conviene crear para el sitio de contenido: `/blog/categoria/<tema>`, `/privacidad`, `/terminos`, `/acerca` (o reutilizar `/bio`), `/ads.txt` y un `404` real.

---

## 2. Estructura del proyecto Astro

Se crea en una carpeta **`site/` dentro de este mismo repo** mientras dura la migración, así Flutter sigue en producción hasta el cambio. Al terminar, `site/` pasa a la raíz y se borra Flutter.

```
site/
├── astro.config.mjs
├── package.json
├── tsconfig.json
├── public/
│   ├── .htaccess              # reglas de URLs (sección 4)
│   ├── ads.txt                # google.com, pub-1686355120044737, DIRECT, f08c47fec0942fa0
│   ├── robots.txt
│   ├── favicon.png
│   ├── og-image.png
│   ├── cv/                    # ← web/cv/*.pdf
│   ├── audio/                 # ← web/audio/
│   ├── stickers/  icons/
│   └── fonts/                 # ← assets/fonts (convertir a woff2)
├── src/
│   ├── content.config.ts      # esquemas de las colecciones (zod)
│   ├── content/
│   │   ├── blog/              # ← assets/blog/posts/*.md  (slug = nombre del archivo)
│   │   │   └── images/        # ← assets/blog/images/  (optimizadas con astro:assets)
│   │   ├── experiencia/       # ← model/experience.dart       → .yaml / .json
│   │   ├── casos/             # ← model/case_study.dart
│   │   ├── servicios/         # ← model/service_offer.dart
│   │   ├── faq/               # ← model/faq_item.dart
│   │   ├── testimonios/       # ← model/testimonial.dart
│   │   ├── changelog/         # ← model/changelog_entry.dart
│   │   └── galeria/           # ← model/gallery.dart
│   ├── data/
│   │   ├── site.ts            # nombre, URL, redes, disponibilidad (← availability.dart)
│   │   └── skills.ts          # ← skill.dart + skill_projects.dart
│   ├── layouts/
│   │   ├── BaseLayout.astro   # <head>, SEO, tema, analytics, AdSense
│   │   ├── PageLayout.astro   # header + footer (← site_header / footer)
│   │   └── PostLayout.astro   # artículo + TOC + anuncios + relacionados
│   ├── components/
│   │   ├── Seo.astro          # title, description, canonical, OG, Twitter, JSON-LD
│   │   ├── AdSlot.astro       # bloque AdSense reutilizable
│   │   ├── Header.astro  Footer.astro  PostCard.astro  Breadcrumbs.astro
│   │   └── vue/               # islas interactivas (solo donde haga falta)
│   │       ├── ThemeToggle.vue        # ← theme_toggle_button.dart
│   │       ├── InteractiveSkills.vue  # ← interactive_skills.dart
│   │       ├── ContactForm.vue        # ← contact_form.dart (mailto / WhatsApp)
│   │       ├── GalleryLightbox.vue    # ← gallery_page.dart
│   │       └── YellowFlowers.vue      # ← flores_amarillas (animación + audio)
│   ├── pages/                 # ver tabla de la sección 1
│   └── styles/
│       └── global.css         # tokens de color/tipografía (← router/style.dart, utils/color.dart)
```

`astro.config.mjs`:

```js
import { defineConfig } from 'astro/config';
import vue from '@astrojs/vue';
import sitemap from '@astrojs/sitemap';
import mdx from '@astrojs/mdx';

export default defineConfig({
  site: 'https://albertoguaman.com',
  trailingSlash: 'never',          // /blog/slug, igual que hoy
  build: { format: 'file' },       // genera /blog/slug.html (no /blog/slug/index.html)
  integrations: [
    vue(),
    mdx(),
    sitemap({ filter: (p) => !/\/(flores-amarillas|nosotros)$/.test(p) }),
  ],
});
```

Esquema del blog (`src/content.config.ts`): conserva los campos del frontmatter actual y suma los que hoy solo están en Dart.

```ts
import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
  loader: glob({ pattern: '*.md', base: './src/content/blog' }),
  schema: ({ image }) => z.object({
    title: z.string(),
    excerpt: z.string(),
    author: z.string().default('Alberto-Guaman'),
    date: z.coerce.date(),
    updated: z.coerce.date().optional(),
    categories: z.array(z.string()).default([]),
    tags: z.array(z.string()).default([]),
    image: image().optional(),     // ruta relativa: ./images/x.jpg
    readTime: z.string().optional(),
    featured: z.boolean().default(false),   // ← hoy en blog_post.dart
    draft: z.boolean().default(false),
  }),
});

export const collections = { blog };
```

---

## 3. Fases (qué se migra primero)

El orden prioriza lo que **genera tráfico y dinero**: primero el blog, después todo lo demás.

### Fase 0: preparación (½ día)
- [ ] Exportar desde Google Search Console las URLs con impresiones de los últimos 12 meses; son la lista de URLs que no se pueden romper.
- [x] Guardar una copia del sitemap y del `rss.xml` actuales → `docs/migracion/legacy/`.
- [x] `npm create astro@latest site`, agregar `@astrojs/vue`, `@astrojs/sitemap` y `@astrojs/rss` (MDX se agrega cuando un post lo necesite).

### Fase 1: base y SEO (1 día)
- [x] `BaseLayout` + `Seo.astro`: portar `web/index.html` (meta, OG, JSON-LD Person/WebSite) y `lib/src/utils/seo.dart` (`pageSeoData`) como props por página.
- [x] `global.css` con los tokens de color y fuentes actuales, con modo oscuro por defecto.
- [x] Header, footer y navegación (← `site_nav.dart`, `footer.dart`).
- [x] Plausible en el `<head>` (solo en el build de producción).

### Fase 2: blog (1–2 días) ← lo más importante
- [x] Copiar los 26 `.md` a `src/content/blog/` **con el mismo nombre de archivo** (el nombre es el slug). Lo hace `site/scripts/migrate-blog.mjs`, que también pasa CRLF a LF y quita el `# Título` repetido al inicio de 3 posts.
- [x] Mover las imágenes a `src/content/blog/images/` y cambiar `image: /blog-images/x.jpg` por `image: ./images/x.jpg`. Salen en WebP a 400–1200 px, con `width`/`height`.
- [x] `featured` ya estaba en el frontmatter; `excerptEn` (8 posts) se copia desde `blog_post.dart` con el mismo script.
- [x] `blog/index.astro` (listado + destacados), `blog/[slug].astro` y `blog/categoria/[topic].astro` con los 7 temas del filtro de Flutter (Flutter, Web, Linux / Homelab, JavaScript, IA, Datos / SQL, Tutoriales).
- [x] **No** se crean páginas `/blog/tag/<tag>`: hay ~120 tags y casi todas tienen un solo post. Serían páginas casi vacías, que perjudican la revisión de AdSense. Las tags se muestran en el post, sin enlace.
- [x] `blog/rss.xml.ts`: misma URL que hoy y 26 entradas. Además corrige las tildes que el feed anterior mostraba rotas (`CÃ³mo`). Se borra `tool/generate_rss.py` al hacer el cambio.
- [x] JSON-LD `BlogPosting` + `BreadcrumbList` en cada post, y `Blog` en el listado.
- [x] Resaltado de código con Shiki (temas claro y oscuro), índice "En este artículo" cuando hay 3 o más `h2` y 3 posts relacionados.
- [x] La página de cada post copia la estructura de `tinguar.com/blog/<slug>`: cabecera con migas de pan, título, resumen, autor/fecha/lectura/"Destacado" y botones de compartir (Facebook, X, LinkedIn, WhatsApp, copiar enlace); portada 1200×630 montada sobre la cabecera; índice lateral fijo + recuadro de contacto (≥1024 px) o índice plegable (móvil); bloques de código con barra de lenguaje y botón "Copiar"; al final, temas del artículo, "← Más artículos" + compartir y 3 relacionados.
- Nota: las 3 imágenes de `/promt/` del post de IA nunca estuvieron en este repo (hoy salen rotas). Ahora apuntan a `https://tinguar.com/promt/...`.

### Fase 3: páginas estáticas (2 días)
- [x] Modelos Dart → `site/src/data/profile.ts` (perfil, experiencia, skills, proyectos, clientes, publicaciones) y `site/src/data/work.ts` (servicios, casos, reseñas, FAQ, changelog). Se usó TypeScript tipado en lugar de YAML: son pocos datos y así se validan al compilar.
- [x] `/` (hero + últimos 3 artículos + sobre mí, experiencia con total de años, herramientas, proyectos, clientes y publicaciones), `/bio`, `/servicios` (JSON-LD `Service`, CTA a WhatsApp por servicio), `/casos`, `/recomendaciones`, `/faq` (JSON-LD `FAQPage`), `/changelog` (con entrada nueva "Octubre 2026 · Nuevo sitio en Astro"), `/cv` (PDF embebido + descargar/abrir).
- [x] `/contacto`: el formulario arma el correo (mailto) o el mensaje de WhatsApp con un script mínimo; no hizo falta Vue.
- Nota: `/recomendaciones` no lleva datos estructurados de reseñas (Google no los muestra cuando son sobre uno mismo) ni el texto "certificadas por Google".

### Fase 4: islas Vue (1–2 días)
- [ ] `ThemeToggle.vue` (`client:load`) + un script inline en el `<head>` para evitar el parpadeo de tema.
- [ ] `InteractiveSkills.vue` (`client:visible`).
- [ ] `GalleryLightbox.vue` (`client:visible`) para `/galeria`.
- [ ] `/flores-amarillas` y `/nosotros`: fotos y audio en Astro, con la animación en `YellowFlowers.vue` (`client:visible`) y `<meta name="robots" content="noindex">`.

### Fase 5: monetización (½ día)
- [ ] `public/ads.txt`.
- [ ] Script de AdSense en `BaseLayout` (solo en producción) y `AdSlot.astro` con un tamaño reservado por CSS para que el anuncio no mueva el contenido (CLS).
- [ ] Ubicaciones en `PostLayout`: después del primer párrafo, a mitad del artículo y al final, antes de los posts relacionados.
- [ ] Páginas `/privacidad` y `/terminos` (AdSense las exige) y enlace en el footer.
- [ ] Banner de consentimiento: el CMP certificado de Google (gratis desde AdSense) si vas a recibir tráfico de la UE o el Reino Unido.

### Fase 6: corte a producción (½ día)
- [ ] Ajustar `public/.htaccess` (sección 4) y `astro build`.
- [ ] Probar en local con Apache o con un subdominio de Hostinger (`nuevo.albertoguaman.com`, con `noindex` mientras tanto).
- [ ] Correr el script de verificación (sección 5).
- [ ] Subir `site/dist/` a `public_html/`. Respaldar antes el `public_html` actual para poder volver atrás en minutos.
- [ ] En Search Console, reenviar el sitemap y usar "Inspeccionar URL" en el home y en 3–4 posts.
- [ ] Antes de borrar: hacer commit de los cambios pendientes de Flutter (modelos, `nosotros`, CVs nuevos), para que queden en el historial de git.
- [ ] Una semana estable → mover `site/` a la raíz y borrar `lib/`, `android/`, `windows/`, `linux/`, `test/`, `pubspec.*`, `firebase.json`, `l10n.yaml`, `analysis_options.yaml`, `tool/`, `web/` y `assets/`. Actualizar el README.

Tiempo total estimado: **7–9 días** de trabajo parcial.

---

## 4. Cómo se conservan las URLs

### 4.1 Sin barra final y sin `.html`
Con `trailingSlash: 'never'` y `build.format: 'file'`, Astro genera `blog.html`, `blog/dart-fundamentos.html`, `cv.html`, etc. Apache tiene que servirlas **sin extensión**, que es como están indexadas hoy.

### 4.2 Conflicto carpeta/página (`/blog` y `/cv`)
Existen a la vez la página `blog.html` y la carpeta `blog/` (posts y `rss.xml`), igual que `cv.html` y `cv/` (PDFs). Por defecto Apache redirige `/blog` a `/blog/` porque ve una carpeta. Se resuelve con `DirectorySlash Off` y con la regla de `.html` **antes** de cualquier lógica de carpetas.

### 4.3 `.htaccess` nuevo (`site/public/.htaccess`)

```apache
Options -Indexes -MultiViews
DirectorySlash Off
ErrorDocument 404 /404.html

<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /

  # HTTPS
  RewriteCond %{HTTPS} !=on
  RewriteCond %{HTTP:X-Forwarded-Proto} !https
  RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

  # www → sin www (si aplica)
  RewriteCond %{HTTP_HOST} ^www\.(.+)$ [NC]
  RewriteRule ^ https://%1%{REQUEST_URI} [L,R=301]

  # Imágenes antiguas de Flutter → nuevas
  RewriteRule ^assets/assets/blog/images/ /blog [L,R=301]

  # Quitar barra final: /blog/ → /blog
  RewriteCond %{REQUEST_URI} !^/$
  RewriteRule ^(.+)/$ /$1 [L,R=301]

  # Quitar .html si alguien lo escribe: /faq.html → /faq
  RewriteCond %{THE_REQUEST} \s/([^.\s?]+)\.html[\s?]
  RewriteRule ^ /%1 [L,R=301]

  # Archivos reales (pdf, xml, imágenes, css, js)
  RewriteCond %{REQUEST_FILENAME} -f
  RewriteRule ^ - [L]

  # /ruta → /ruta.html si existe (resuelve /blog, /cv, /blog/slug)
  RewriteCond %{DOCUMENT_ROOT}/$1.html -f
  RewriteRule ^(.+)$ $1.html [L]

  # Lo demás: 404 real (ya NO se manda todo a index.html)
</IfModule>

<IfModule mod_headers.c>
  Header always set X-Content-Type-Options "nosniff"
  Header always set Referrer-Policy "strict-origin-when-cross-origin"
  Header always set X-Frame-Options "SAMEORIGIN"
  Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
  <FilesMatch "\.(js|css|woff2|webp|avif|jpg|png|svg)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
  </FilesMatch>
</IfModule>
```

> Nota: Astro pone hash en los nombres de los archivos de `/_astro/`, así que se pueden cachear por un año. Las imágenes de `public/` no llevan hash; si cambias una, cámbiale también el nombre.

Las imágenes antiguas de Flutter redirigen a `/blog`: no tienen tráfico propio y copiarlas a `public/` duplicaría 17 MB.

### 4.4 Canonical y sitemap
- `Seo.astro` arma el canonical como `new URL(Astro.url.pathname, Astro.site)`, sin barra final. Es idéntico al actual.
- `@astrojs/sitemap` genera `sitemap-index.xml`. Agregar en `.htaccess` `RewriteRule ^sitemap\.xml$ /sitemap-index.xml [L,R=301]` o cambiar el sitemap en `robots.txt` y en Search Console. Lo primero es más seguro.
- `/flores-amarillas` y `/nosotros` quedan fuera del sitemap y con `noindex`, igual que hoy, que tampoco están en él.

### 4.5 Si más adelante cambias de hosting
En Cloudflare Pages o Netlify, las reglas de 4.3 se reemplazan por un `public/_redirects`. Ahí `trailingSlash: 'never'` funciona sin configuración extra.

---

## 5. Verificación antes y después del corte

Script `site/scripts/check-urls.mjs`: lee el sitemap **antiguo** (`web/sitemap.xml`) + la lista exportada de Search Console y hace `fetch` a cada URL contra el entorno de prueba.

- [ ] Todas responden **200** (no 301 ni 404), excepto las que tienen redirección prevista.
- [ ] El `<title>` y el `<link rel="canonical">` de cada una coinciden con la URL pedida.
- [ ] `/blog/rss.xml`, `/cv/cv_sep_2026.pdf`, `/robots.txt`, `/ads.txt` y `/sitemap.xml` responden.
- [ ] `/blog/` → 301 → `/blog`; `/faq.html` → 301 → `/faq`; `/no-existe` → **404** real.
- [ ] Lighthouse móvil ≥ 95 en rendimiento y SEO para `/` y para un post.
- [ ] Rich Results Test sin errores en un post (`BlogPosting`) y en `/faq` (`FAQPage`).

Después del corte, revisar en Search Console durante 2–4 semanas: cobertura (que no suban los 404), Core Web Vitals e impresiones por URL.

---

## 6. Decisiones abiertas

- **Vue o solo Astro.** Las islas listadas son pocas y pequeñas. Si no planeas componentes más complejos (herramientas, calculadoras, dashboards), Astro con un `<script>` simple basta y te ahorras la dependencia. Vue tiene sentido si el sitio va a incluir **herramientas interactivas** como contenido (p. ej. la calculadora de porcentaje de tarjeta).
- **MDX.** Úsalo solo en posts que necesiten insertar componentes (una calculadora dentro del artículo, por ejemplo). El resto puede seguir en `.md`.
- **Inglés.** Hoy el sitio está solo en español. Si más adelante quieres inglés, Astro tiene i18n con rutas `/en/...`, y conviene decidirlo antes de la fase 2.
