import 'package:flutter/services.dart';

/// Quita el frontmatter YAML del markdown.
String stripMarkdownFrontmatter(String raw) {
  final match = RegExp(r'^---\r?\n[\s\S]*?\r?\n---\r?\n?', multiLine: false)
      .firstMatch(raw);
  if (match == null) return raw.trimLeft();
  return raw.substring(match.end).trimLeft();
}

/// Convierte rutas `/blog-images/...` a assets locales.
String rewriteBlogImagePaths(String markdown) {
  return markdown.replaceAllMapped(
    RegExp(r'(!?\[[^\]]*\]\()(/blog-images/)([^)\s]+)(\))'),
    (m) => '${m[1]}assets/blog/images/${m[3]}${m[4]}',
  );
}

Future<String> loadBlogMarkdownBody(String assetPath) async {
  final raw = await rootBundle.loadString(assetPath);
  return rewriteBlogImagePaths(stripMarkdownFrontmatter(raw));
}

String? blogImageAssetFromUri(Uri uri) {
  final path = uri.path;
  if (path.startsWith('assets/blog/images/')) return path;
  if (path.startsWith('/blog-images/')) {
    return 'assets/blog/images/${path.split('/').last}';
  }
  if (path.contains('blog-images/')) {
    return 'assets/blog/images/${path.split('/').last}';
  }
  return null;
}
