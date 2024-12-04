import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home/home.dart';
import '../home/porfolio/porfolio.dart';
import '../src/home/home.dart';
import 'router.dart';

final goRouter = GoRouter(
  errorBuilder: (context, state) => const Home(),
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
           // return transitionPageRouter(state.pageKey, const HomePortfolio());
           return transitionPageRouter(state.pageKey, const HomeSrc());
        // return transitionPageRouter(state.pageKey, const Home());
      },
    ),
    GoRoute(
      path: '/portafolio',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return transitionPageRouter(state.pageKey, const Portafolio());
      },
    ),
    GoRoute(
      path: '/original',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return transitionPageRouter(state.pageKey, const OriginalPorfolio());
      },
    )
  ],
);
