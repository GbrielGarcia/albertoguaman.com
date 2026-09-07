import 'package:url_launcher/url_launcher.dart';

Future<void> laucherURL(String url) async {
  final Uri uri = _resolveUri(url);
  if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
    throw 'Sin contenido $url';
  }
}

Uri _resolveUri(String url) {
  if (url.startsWith('http://') ||
      url.startsWith('https://') ||
      url.startsWith('mailto:') ||
      url.startsWith('tel:')) {
    return Uri.parse(url);
  }
  if (url.startsWith('/')) {
    return Uri.base.replace(path: url, query: null, fragment: null);
  }
  return Uri.base.resolve(url);
}
