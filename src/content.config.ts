import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

// Un post = un .md en src/content/blog/ (imágenes en ./images/).
// El nombre del archivo es el slug: /blog/<archivo-sin-.md>.
const blog = defineCollection({
  loader: glob({ pattern: '*.md', base: './src/content/blog' }),
  schema: ({ image }) =>
    z.object({
      title: z.string(),
      excerpt: z.string(),
      excerptEn: z.string().optional(),
      author: z.string().default('Alberto-Guaman'),
      date: z.coerce.date(),
      updated: z.coerce.date().optional(),
      categories: z.array(z.string()).default([]),
      tags: z.array(z.string()).default([]),
      image: image().optional(),
      readTime: z.string().optional(),
      featured: z.boolean().default(false),
      draft: z.boolean().default(false),
    }),
});

export const collections = { blog };
