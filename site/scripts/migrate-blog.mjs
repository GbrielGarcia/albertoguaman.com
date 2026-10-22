#!/usr/bin/env node
// Copia los posts de Flutter (assets/blog/) a la colección de Astro (src/content/blog/).
// Es idempotente: se puede volver a correr si se edita algún post en el lado Flutter.
//
//   node scripts/migrate-blog.mjs
//
// - /blog-images/x.jpg → ./images/x.jpg (para que astro:assets optimice).
// - /promt/... → https://tinguar.com/promt/... (las imágenes solo existen allí).
// - Agrega excerptEn desde lib/src/model/blog_post.dart si el post lo tenía.
// - Quita `gradient` (clases Tailwind del blog Tinguar, aquí no se usan).
// - Quita el "# Título" inicial que algunos posts repiten.
import { copyFileSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const SITE = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const ROOT = resolve(SITE, '..');
const SRC_POSTS = join(ROOT, 'assets/blog/posts');
const SRC_IMAGES = join(ROOT, 'assets/blog/images');
const DART = join(ROOT, 'lib/src/model/blog_post.dart');
const OUT = join(SITE, 'src/content/blog');
const OUT_IMAGES = join(OUT, 'images');

mkdirSync(OUT_IMAGES, { recursive: true });

// slug → excerptEn, leído del catálogo Dart.
const dart = readFileSync(DART, 'utf8');
const excerptEn = new Map();
for (const block of dart.split(/BlogPost\(/).slice(1)) {
  const slug = block.match(/slug:\s*"([^"]+)"/)?.[1];
  const en = block.match(/excerptEn:\s*((?:"(?:\\.|[^"\\])*"\s*)+),/)?.[1];
  if (slug && en) {
    excerptEn.set(slug, [...en.matchAll(/"((?:\\.|[^"\\])*)"/g)].map((m) => m[1]).join(''));
  }
}

const images = readdirSync(SRC_IMAGES);
for (const img of images) copyFileSync(join(SRC_IMAGES, img), join(OUT_IMAGES, img));

const posts = readdirSync(SRC_POSTS).filter((f) => f.endsWith('.md') && f !== 'README.md');
for (const file of posts) {
  const slug = file.replace(/\.md$/, '');
  // 21 de los posts originales vienen con CRLF; se normaliza a LF.
  const raw = readFileSync(join(SRC_POSTS, file), 'utf8').replace(/\r\n/g, '\n');
  const match = raw.match(/^---\n([\s\S]*?)\n---\n?([\s\S]*)$/);
  if (!match) throw new Error(`${file}: frontmatter no encontrado`);
  let [, fm, body] = match;

  fm = fm
    .split('\n')
    .filter((line) => !line.startsWith('gradient:'))
    .join('\n')
    .replace(/^image:\s*"?\/blog-images\/([^"\n]+)"?$/m, 'image: ./images/$1');

  if (excerptEn.has(slug) && !/^excerptEn:/m.test(fm)) {
    fm += `\nexcerptEn: ${JSON.stringify(excerptEn.get(slug))}`;
  }

  body = body
    // El título ya es el <h1> de la página; algunos posts lo repetían al inicio.
    .replace(/^\s*# [^\n]*\n+/, '')
    .replaceAll('](/blog-images/', '](./images/')
    .replaceAll('src="/promt/', 'src="https://tinguar.com/promt/');

  writeFileSync(join(OUT, file), `---\n${fm}\n---\n${body}`);
}

console.log(`✓ ${posts.length} posts y ${images.length} imágenes → ${OUT}`);
console.log(`  excerptEn agregado a ${excerptEn.size} posts`);
