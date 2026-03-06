// Implementación real con dart:html (solo en web con JavaScript, no en WASM).
import 'dart:html' as html;

const String _siteName = 'Alberto Guaman';
const String _baseUrl = 'https://albertoguaman.com';

void setPageSEO({
  required String title,
  required String description,
  String? path,
}) {
  final fullTitle = title.contains(_siteName) ? title : '$title | $_siteName';
  html.document.title = fullTitle;

  _setMeta('name', 'description', description);
  _setMeta('property', 'og:title', fullTitle);
  _setMeta('property', 'og:description', description);
  _setMeta('property', 'og:url', path != null ? '$_baseUrl$path' : _baseUrl);
}

void _setMeta(String attribute, String key, String value) {
  final selector = attribute == 'name'
      ? 'meta[$attribute="$key"]'
      : 'meta[$attribute="$key"]';
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
