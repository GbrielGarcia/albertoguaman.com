import { getCollection, type CollectionEntry } from 'astro:content';

export type Post = CollectionEntry<'blog'>;

/**
 * Temas del blog (← _blogFilters en lib/src/blog/blog_list_page.dart).
 * Agrupan las categorías sueltas de cada post; cada tema tiene su página /blog/categoria/<id>.
 */
export const TOPICS = [
  {
    id: 'flutter',
    label: 'Flutter',
    description: 'Tutoriales de Flutter y Dart: arquitectura, estado, temas, paywalls y despliegue.',
    keywords: ['flutter', 'dart', 'móvil', 'mobile', 'provider', 'paywall', 'enum', 'firebase'],
  },
  {
    id: 'web',
    label: 'Web',
    description: 'Desarrollo web: Astro, frontend, DOM, generadores estáticos, hosting y despliegue.',
    keywords: ['web', 'astro', 'frontend', 'html', 'lit', 'dom', 'pelican', 'despliegue', 'hosting'],
  },
  {
    id: 'linux',
    label: 'Linux / Homelab',
    description: 'Servidores en casa, NAS con ZimaOS, Docker, túneles y personalización del terminal.',
    keywords: ['linux', 'nas', 'homelab', 'servidor', 'neovim', 'lazyvim', 'xfce', 'terminal'],
  },
  {
    id: 'javascript',
    label: 'JavaScript',
    description: 'JavaScript práctico: tipos de datos, DOM, HTTP y librerías.',
    keywords: ['javascript', 'tipos', 'dom', 'http'],
  },
  {
    id: 'ia',
    label: 'IA',
    description: 'Inteligencia artificial aplicada: generación de imágenes y prompts.',
    keywords: ['ia', 'inteligencia', 'moda'],
  },
  {
    id: 'datos',
    label: 'Datos / SQL',
    description: 'Bases de datos, SQL y herramientas de cálculo.',
    keywords: ['sql', 'base', 'finanzas'],
  },
  {
    id: 'tutorial',
    label: 'Tutoriales',
    description: 'Guías paso a paso de desarrollo, servidores y herramientas.',
    keywords: ['tutorial'],
  },
] as const;

export type Topic = (typeof TOPICS)[number];

export function postMatchesTopic(post: Post, topic: Topic): boolean {
  const cats = post.data.categories.map((c) => c.toLowerCase()).join(' ');
  return topic.keywords.some((k) => cats.includes(k));
}

export function topicsOf(post: Post): Topic[] {
  return TOPICS.filter((t) => t.id !== 'tutorial' && postMatchesTopic(post, t));
}

/** Posts publicados, del más reciente al más antiguo. */
export async function getPosts(): Promise<Post[]> {
  const posts = await getCollection('blog', ({ data }) => import.meta.env.DEV || !data.draft);
  return posts.sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
}

/** Hasta `limit` posts que comparten tema con `post`, priorizando los que comparten más categorías. */
export function relatedPosts(post: Post, all: Post[], limit = 3): Post[] {
  const cats = new Set(post.data.categories.map((c) => c.toLowerCase()));
  const topics = new Set(topicsOf(post).map((t) => t.id));
  return all
    .filter((p) => p.id !== post.id)
    .map((p) => ({
      p,
      score:
        p.data.categories.filter((c) => cats.has(c.toLowerCase())).length * 2 +
        topicsOf(p).filter((t) => topics.has(t.id)).length,
    }))
    .filter(({ score }) => score > 0)
    .sort((a, b) => b.score - a.score || b.p.data.date.valueOf() - a.p.data.date.valueOf())
    .slice(0, limit)
    .map(({ p }) => p);
}

const dateFormat = new Intl.DateTimeFormat('es-EC', {
  day: 'numeric',
  month: 'long',
  year: 'numeric',
  timeZone: 'UTC',
});

/** Las fechas del frontmatter son días (UTC); se formatean en UTC para no restar un día. */
export function formatDate(date: Date): string {
  return dateFormat.format(date);
}
