import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/routes/route_config.dart';

class StopWatchAppView extends StatelessWidget {
  StopWatchAppView({super.key});

  final GoRouter _router = AppRouter.buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
    );
  }
}
