import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/login/presentation/auth_view.dart';
import 'package:stopwatch/features/login/presentation/login_view.dart';

import '../features/login/presentation/sign_up_view.dart';

class AppRouter {
  AppRouter._();

  static const String loginRoute = 'login';
  static const String authRoute = 'auth';
  static const String registerRoute = 'sign_up';
  static const String stopwatchRoute = 'stopwatch';
  static const String history = 'history';

  static GoRouter buildRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          name: authRoute,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(child: AuthenticationView());
          },
        ),
        GoRoute(
          name: loginRoute,
          path: '/$loginRoute',
          pageBuilder: (context, state) {
            return const MaterialPage(child: LoginView());
          },
        ),
        GoRoute(
          name: registerRoute,
          path: '/$registerRoute',
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignUpView());
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
