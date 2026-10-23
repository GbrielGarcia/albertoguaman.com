#!/usr/bin/env node
// Verifica que el sitio publicado (o una copia local en Apache) responda bien en todas las URLs
// que Google ya conoce y en las reglas de redirección del .htaccess.
//
//   node scripts/check-urls.mjs https://albertoguaman.com
//   node scripts/check-urls.mjs http://localhost:8089
import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const base = (process.argv[2] ?? 'https://albertoguaman.com').replace(/\/$/, '');
const here = dirname(fileURLToPath(import.meta.url));

// URLs del sitemap del sitio anterior (copia en scripts/legacy-urls.txt).
const legacy = readFileSync(join(here, 'legacy-urls.txt'), 'utf8')
  .split('\n')
  .map((l) => l.trim())
  .filter((l) => l && !l.startsWith('#'));

/** [ruta, estado esperado, destino esperado si es redirección] */
const checks = [
  ...legacy.map((p) => [p, 200]),
  ['/blog/rss.xml', 200],
  ['/robots.txt', 200],
  ['/ads.txt', 200],
  ['/sitemap-index.xml', 200],
  ['/cv/2026_cv_st.pdf', 200],
  ['/galeria', 200],
  ['/privacidad', 200],
  ['/terminos', 200],
  ['/blog/categoria/flutter', 200],
  ['/sitemap.xml', 301, '/sitemap-index.xml'],
  ['/blog/', 301, '/blog'],
  ['/faq.html', 301, '/faq'],
  ['/index.html', 301, '/'],
  ['/assets/assets/blog/images/sql-basico.jpg', 301, '/blog'],
  ['/nosotros', 410],
  ['/flores-amarillas', 410],
  ['/main.dart.js', 410],
  ['/esta-pagina-no-existe', 404],
];

let failed = 0;
for (const [path, status, location] of checks) {
  const res = await fetch(base + path, { redirect: 'manual' });
  const loc = res.headers.get('location')?.replace(base, '') ?? '';
  let ok = res.status === status && (!location || loc === location);

  // En las 200 de HTML, el canonical debe ser la propia URL.
  let note = '';
  if (ok && status === 200 && (res.headers.get('content-type') ?? '').includes('text/html')) {
    const html = await res.text();
    const canonical = html.match(/<link rel="canonical" href="([^"]+)"/)?.[1];
    const expected = `https://albertoguaman.com${path === '/' ? '/' : path}`;
    if (canonical !== expected) {
      ok = false;
      note = ` canonical=${canonical}`;
    }
  }

  if (!ok) failed++;
  console.log(`${ok ? 'ok  ' : 'FAIL'} ${res.status} ${path}${loc ? ` → ${loc}` : ''}${note}`);
}

console.log(failed ? `\n✗ ${failed} de ${checks.length} fallaron` : `\n✓ ${checks.length} URLs correctas`);
process.exit(failed ? 1 : 0);
