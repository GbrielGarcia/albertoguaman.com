import { SITE } from '../data/site';

export interface Crumb {
  label: string;
  href: string;
}

/** Nodo JSON-LD BreadcrumbList para pasar a <Seo jsonLd>. */
export function breadcrumbJsonLd(items: Crumb[]) {
  return {
    '@type': 'BreadcrumbList',
    itemListElement: items.map((item, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: item.label,
      item: new URL(item.href, SITE.url).href,
    })),
  };
}
