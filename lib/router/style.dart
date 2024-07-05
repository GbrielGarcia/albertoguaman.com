import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage transitionPageRouter(LocalKey pageKey, Widget child) {
  return CustomTransitionPage(
    key: pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeIn).animate(animation),
        child: child,
      );
    },
  );
}