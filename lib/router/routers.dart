import 'package:albertoguaman/src/home/bio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/home/home.dart';
import 'router.dart';

final goRouter = GoRouter(
  errorBuilder: (context, state) => const HomeSrc(),
  initialLocation: '/bio',
  routes: <RouteBase>[
    GoRoute(
      path: '/inicio',
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
