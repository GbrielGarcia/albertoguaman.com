import 'package:flutter/foundation.dart';

/// Subdominio de ventas / asesoría comercial.
const String marcimexSubdomain = 'marcimex';

/// Devuelve true si [uri] corresponde al sitio Marcimex: host con "marcimex"
/// o query param marcimex=1|true|yes (para probar en localhost).
bool isMarcimexSiteFromUri(Uri uri) {
  final host = uri.host.toLowerCase();
  if (host.isNotEmpty && host.contains(marcimexSubdomain)) return true;
  final q = uri.queryParameters['marcimex']?.toLowerCase();
  return q == '1' || q == 'true' || q == 'yes';
}

/// Devuelve true si la app corre en web y el host es marcimex.albertoguaman.com
/// (o contiene "marcimex"). En móvil/desktop siempre false.
///
/// Para ver la página Marcimex en localhost, abre por ejemplo:
///   http://localhost:59094/?marcimex=1
bool get isMarcimexSite {
  if (!kIsWeb) return false;
  return isMarcimexSiteFromUri(Uri.base);
}
