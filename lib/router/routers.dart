import 'package:albertoguaman/src/home/bio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/home/home.dart';
import '../src/utils/utils.dart';
import 'router.dart';

/// Rutas válidas de la app. Cualquier otra ruta se redirige a inicio.
const _validPaths = ['/', '/bio'];

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final path = state.uri.path;
    final normalized = path.endsWith('/') && path.length > 1
        ? path.substring(0, path.length - 1)
        : path;
    if (_validPaths.contains(normalized)) return null;
    return '/';
  },
  errorBuilder: (context, state) => _NotFoundPage(
    onGoHome: () => context.go('/'),
  ),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return transitionPageRouter(state.pageKey, const HomeSrc());
      },
    ),
    GoRoute(
      path: '/bio',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return transitionPageRouter(state.pageKey, const Bio());
      },
    ),
  ],
);

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage({required this.onGoHome});

  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColor.colorPrimaryDark,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, size: 64, color: Colors.white54),
              const SizedBox(height: 16),
              Text(
                'Página no encontrada',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'La ruta que buscas no existe.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onGoHome,
                icon: const Icon(Icons.home),
                label: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
