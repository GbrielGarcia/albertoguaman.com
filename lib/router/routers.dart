import 'package:go_router/go_router.dart';

import '../home/home.dart';
import '../home/porfolio/porfolio.dart';
import 'router.dart';

final goRouter = GoRouter(
  errorBuilder: (context, state) => const Home(),
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return transitionPageRouter(state.pageKey, const Home());
      },
    ),
    GoRoute(
      path: '/portafolio',
      pageBuilder: (context, state) {
        return transitionPageRouter(state.pageKey, const Portafolio());
      },
    ),
    GoRoute(
      path: '/original',
      pageBuilder: (context, state) {
        return transitionPageRouter(state.pageKey, const OriginalPorfolio());
      },
    )
  ],
);
