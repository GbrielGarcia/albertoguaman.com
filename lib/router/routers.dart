import 'package:albertoguaman/src/blog/blog_detail_page.dart';
import 'package:albertoguaman/src/blog/blog_list_page.dart';
import 'package:albertoguaman/src/cases/case_studies_page.dart';
import 'package:albertoguaman/src/changelog/changelog_page.dart';
import 'package:albertoguaman/src/contact/contact_page.dart';
import 'package:albertoguaman/src/cv/cv_page.dart';
import 'package:albertoguaman/src/faq/faq_page.dart';
import 'package:albertoguaman/src/gallery/gallery_page.dart';
import 'package:albertoguaman/src/home/bio.dart';
import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/recommendations/recommendations_page.dart';
import 'package:albertoguaman/src/services/services_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/home/home.dart';
import '../src/utils/utils.dart';
import '../src/utils/seo.dart';
import '../src/widget/bubble_background_effect.dart';
import 'router.dart';

/// Rutas conocidas de la app (útil para tests y redirects).
bool isValidAppPath(String path) {
  if (path == '/' ||
      path == '/bio' ||
      path == '/blog' ||
      path == '/galeria' ||
      path == '/contacto' ||
      path == '/cv' ||
      path == '/casos' ||
      path == '/recomendaciones' ||
      path == '/servicios' ||
      path == '/faq' ||
      path == '/changelog') {
    return true;
  }
  if (path.startsWith('/blog/')) {
    final slug = path.substring('/blog/'.length);
    return slug.isNotEmpty &&
        !slug.contains('/') &&
        blogPostBySlug(slug) != null;
  }
  return false;
}

void _updateSeoForRoute(GoRouterState state) {
  String path = state.uri.path;
  if (path.endsWith('/') && path.length > 1) {
    path = path.substring(0, path.length - 1);
  }
  if (path.startsWith('/blog/') && path != '/blog') {
    final slug = path.substring('/blog/'.length);
    final post = blogPostBySlug(slug);
    if (post != null) {
      final image = post.imageAsset.isNotEmpty
          ? 'https://albertoguaman.com/${post.imageAsset}'
          : null;
      setPageSEO(
        title: post.title,
        description: post.excerpt,
        path: path,
        imageUrl: image,
      );
      return;
    }
  }
  final data = pageSeoData[path];
  if (data != null) {
    setPageSEO(title: data.$1, description: data.$2, path: path);
  }
}

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final path = state.uri.path;
    final normalized = path.endsWith('/') && path.length > 1
        ? path.substring(0, path.length - 1)
        : path;
    if (isValidAppPath(normalized)) return null;
    return '/';
  },
  errorBuilder: (context, state) => _NotFoundPage(
    onGoHome: () => context.go('/'),
  ),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const HomeSrc());
      },
    ),
    GoRoute(
      path: '/bio',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const Bio());
      },
    ),
    GoRoute(
      path: '/blog',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const BlogListPage());
      },
    ),
    GoRoute(
      path: '/blog/:slug',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        final slug = state.pathParameters['slug'] ?? '';
        return transitionPageRouter(
          state.pageKey,
          BlogDetailPage(slug: slug),
        );
      },
    ),
    GoRoute(
      path: '/galeria',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const GalleryPage());
      },
    ),
    GoRoute(
      path: '/casos',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const CaseStudiesPage());
      },
    ),
    GoRoute(
      path: '/recomendaciones',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(
            state.pageKey, const RecommendationsPage());
      },
    ),
    GoRoute(
      path: '/contacto',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const ContactPage());
      },
    ),
    GoRoute(
      path: '/cv',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const CvPage());
      },
    ),
    GoRoute(
      path: '/servicios',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const ServicesPage());
      },
    ),
    GoRoute(
      path: '/faq',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const FaqPage());
      },
    ),
    GoRoute(
      path: '/changelog',
      pageBuilder: (BuildContext context, GoRouterState state) {
        _updateSeoForRoute(state);
        return transitionPageRouter(state.pageKey, const ChangelogPage());
      },
    ),
  ],
);

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage({required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: UtilsColor.colorPrimaryDark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => laucherURL('https://wa.me/593992889078'),
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        elevation: 10,
        icon: const Icon(Icons.chat),
        label: const Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: BubbleBackgroundLayer(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off,
                          size: 64, color: Colors.white54),
                      const SizedBox(height: 16),
                      Text(
                        al?.pageNotFound ?? 'Página no encontrada',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        al?.pageNotFoundHint ?? 'La ruta que buscas no existe.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white70,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: onGoHome,
                        icon: const Icon(Icons.home),
                        label: Text(al?.backToHome ?? 'Volver al inicio'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const BubbleBackgroundToggleOverlay(),
        ],
      ),
    );
  }
}
