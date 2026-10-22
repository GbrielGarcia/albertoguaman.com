/**
 * Ruta pública canónica: sin .html, sin barra final y con /index → /.
 * Con build.format 'file', Astro.url.pathname vale "/index" o "/blog.html" según el modo.
 */
export function publicPath(pathname: string): string {
  const path = pathname
    .replace(/\.html$/, '')
    .replace(/(^|\/)index$/, '$1')
    .replace(/(.)\/$/, '$1');
  return path === '' ? '/' : path;
}
