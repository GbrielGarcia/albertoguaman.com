// @ts-check
import { defineConfig } from 'astro/config';

import vue from '@astrojs/vue';
import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://albertoguaman.com',
  // URLs sin barra final, como las indexa Google hoy (/blog/slug).
  trailingSlash: 'never',
  // Genera blog/slug.html (no blog/slug/index.html); el .htaccess lo sirve sin extensión.
  build: { format: 'file' },
  markdown: {
    // Dos temas de código; global.css elige uno según data-theme.
    shikiConfig: {
      themes: { light: 'github-light', dark: 'github-dark' },
      defaultColor: false,
    },
  },
  integrations: [
    vue(),
    sitemap(),
  ],
});
