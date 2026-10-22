import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { getPosts } from '../../data/blog';
import { SITE } from '../../data/site';

// Misma URL que el feed anterior (/blog/rss.xml), así los lectores RSS no se pierden.
export async function GET(context: APIContext) {
  const posts = await getPosts();
  return rss({
    title: `${SITE.name} · Blog`,
    description: 'Artículos sobre desarrollo, Flutter, web y tecnología.',
    site: context.site ?? SITE.url,
    trailingSlash: false,
    customData: '<language>es-ec</language>',
    items: posts.map((post) => ({
      title: post.data.title,
      description: post.data.excerpt,
      pubDate: post.data.date,
      link: `/blog/${post.id}`,
      categories: post.data.categories,
    })),
  });
}
