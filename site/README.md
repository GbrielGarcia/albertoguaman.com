# albertoguaman.com (Astro)

Nueva versión del sitio en Astro. Reemplazará a la app Flutter web de la raíz del repo. El plan completo está en [`../docs/migracion-astro.md`](../docs/migracion-astro.md).

```sh
npm install
npm run dev      # http://localhost:4321
npm run build    # genera dist/
npm run preview
```

## Estructura

- `src/data/site.ts`: nombre, navegación, SEO por ruta y JSON-LD base.
- `src/components/Seo.astro`: title, description, canonical, Open Graph, Twitter y JSON-LD.
- `src/layouts/BaseLayout.astro`: `<head>`, tema, Plausible (solo en producción).
- `src/layouts/PageLayout.astro`: header + main + footer.
- `src/styles/global.css`: tokens de color y tipografía (oscuro por defecto, claro con `data-theme="light"`).
- `public/`: archivos que conservan su URL actual (`/cv/*.pdf`, `/audio/`, `/stickers/`, `/icons/`, `/og-image.png`).

## URLs

`trailingSlash: 'never'` + `build.format: 'file'` → `dist/blog.html`, `dist/blog/slug.html`. En Hostinger, el `.htaccess` (fase 6) las sirve sin extensión.
