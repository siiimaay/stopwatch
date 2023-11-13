import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/auth/presentation/login_view.dart';
import 'package:stopwatch/features/history/data/history_detail.dart';

import '../features/auth/presentation/auth_view.dart';
import '../features/auth/presentation/sign_up_view.dart';
import '../features/history/presentation/stopwatch_detail.dart';
import '../features/stopwatch/presentation/stopwatch.dart';

class AppRouter {
  AppRouter._();

  static const String loginRoute = 'login';
  static const String authRoute = 'auth';
  static const String registerRoute = 'sign_up';
  static const String stopwatchRoute = 'stopwatch';
  static const String historyDetailRoute = 'history_detail';

  static GoRouter buildRouter() {
    final hasUserLoggedIn = FirebaseAuth.instance.currentUser?.uid != null;
    return GoRouter(
      routes: [
        GoRoute(
          name: authRoute,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: hasUserLoggedIn
                    ? StopWatchAppView()
                    : AuthenticationView());
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
            return MaterialPage(child: StopWatchAppView());
          },
        ),
        GoRoute(
            name: historyDetailRoute,
            path: '/$historyDetailRoute',
            builder: (context, state) {
              final extra = state.extra as HistoryDetail;
              return StopwatchDetailView(
                duration: extra.duration ?? "",
                laps: extra.laps ?? [],
                name: extra.name ?? "",
                onDelete: extra.onDelete,
              );
            }),
      ],
    );
  }
}
