import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/login/presentation/login_view.dart';

class AppRouter {
  AppRouter._();

  static const String loginRoute = 'login';
  static const String stopwatchRoute = 'stopwatch';
  static const String history = 'history';

  static GoRouter buildRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          name: loginRoute,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginView());
          },
        ),
        GoRoute(
          name: stopwatchRoute,
          path: '/$stopwatchRoute',
          pageBuilder: (context, state) {
            return const MaterialPage(child: Placeholder());
          },
        ),
        GoRoute(
          name: history,
          path: '/$history',
          pageBuilder: (context, state) {
            return const MaterialPage(child: Placeholder());
          },
        ),
      ],
    );
  }
}
