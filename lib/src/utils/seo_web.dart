// Implementación real con dart:html (solo en web con JavaScript, no en WASM).
import 'dart:html' as html;

const String _siteName = 'Alberto Guaman';
const String _baseUrl = 'https://albertoguaman.com';
const String _ogImage = 'https://albertoguaman.com/og-image.png';

void setPageSEO({
  required String title,
  required String description,
  String? path,
  String? imageUrl,
}) {
  final normalizedPath = (path == null || path.isEmpty || path == '/')
      ? '/'
      : (path.startsWith('/') ? path : '/$path');
  final pageUrl =
      normalizedPath == '/' ? '$_baseUrl/' : '$_baseUrl$normalizedPath';
  final fullTitle =
      title.contains(_siteName) ? title : '$title | $_siteName';
  final ogImage = (imageUrl != null && imageUrl.isNotEmpty)
      ? (imageUrl.startsWith('http')
          ? imageUrl
          : '$_baseUrl${imageUrl.startsWith('/') ? imageUrl : '/$imageUrl'}')
      : _ogImage;

  html.document.title = fullTitle;

  _setMeta('name', 'description', description);
  _setMeta('property', 'og:title', fullTitle);
  _setMeta('property', 'og:description', description);
  _setMeta('property', 'og:url', pageUrl);
  _setMeta('property', 'og:type',
      normalizedPath.startsWith('/blog/') ? 'article' : 'website');
  _setMeta('property', 'og:site_name', _siteName);
  _setMeta('property', 'og:image', ogImage);
  _setMeta('property', 'og:image:secure_url', ogImage);
  _setMeta('property', 'og:locale', 'es_EC');

  _setMeta('name', 'twitter:card', 'summary_large_image');
  _setMeta('name', 'twitter:title', fullTitle);
  _setMeta('name', 'twitter:description', description);
  _setMeta('name', 'twitter:image', ogImage);

  _setCanonical(pageUrl);
}

void _setCanonical(String url) {
  var link = html.document.querySelector('link[rel="canonical"]')
      as html.LinkElement?;
  if (link == null) {
    link = html.LinkElement()
      ..rel = 'canonical'
      ..href = url;
    html.document.head?.append(link);
  } else {
    link.href = url;
  }
}

void _setMeta(String attribute, String key, String value) {
  final selector = 'meta[$attribute="$key"]';
  var el = html.document.querySelector(selector) as html.MetaElement?;
  if (el == null) {
    el = html.MetaElement()
      ..setAttribute(attribute, key)
      ..content = value;
    html.document.head?.append(el);
  } else {
    el.content = value;
  }
}
