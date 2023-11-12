import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:stopwatch/features/auth/presentation/wave_shape_clipper.dart';
import 'package:stopwatch/widgets/action_button.dart';

import '../../../routes/route_config.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: ClipPath(
              clipper: HeaderWaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xFFD1C4E9),
                    Color(0xFFBBDEFB),
                  ],
                )),
                child: Lottie.asset('assets/animations/login_timer.json'),
              ),
            ),
          ),
          Flexible(
            child: ActionButton(
              buttonText: 'Login',
              onPressed: () =>
                  GoRouter.of(context).pushNamed(AppRouter.loginRoute),
              buttonSize: const Size(300, 50),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD1C4E9),
                  Color(0xFFBBDEFB),
                ],
              ),
              textColor: Colors.indigo,
            ),
          ),
          const SizedBox(height: 30),
          Flexible(
            child: ActionButton(
              buttonText: 'Sign Up',
              onPressed: () =>
                  GoRouter.of(context).pushNamed(AppRouter.registerRoute),
              buttonSize: const Size(300, 50),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD1C4E9),
                  Color(0xFFBBDEFB),
                ],
              ),
              textColor: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}
