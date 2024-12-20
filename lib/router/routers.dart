import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../src/home/home.dart';
import 'router.dart';

final goRouter = GoRouter(
  errorBuilder: (context, state) => const HomeSrc(),
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
           return transitionPageRouter(state.pageKey, const HomeSrc());
      },
    ),
  ],
);
