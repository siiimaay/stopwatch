import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/login/presentation/common_widgets/form_field_label.dart';
import 'package:stopwatch/routes/route_config.dart';
import 'package:stopwatch/widgets/action_button.dart';

import 'common_widgets/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.w500),
        ),
        elevation: 0.8,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFD1C4E9),
            Color(0xFFBBDEFB),
          ])),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormFieldLabel(label: 'Email'),
            Flexible(
                child: AuthTextField(
              controller: _emailController,
            )),
            const FormFieldLabel(label: 'Password'),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: AuthTextField(controller: _passwordController)),
            Center(
              child: ActionButton(
                buttonText: "Login",
                onPressed: () {
                  GoRouter.of(context).go('/${AppRouter.stopwatchRoute}');
                },
                textColor: Colors.indigo,
                buttonSize: const Size(200, 50),
                gradient: const LinearGradient(colors: [
                  Color(0xFFD1C4E9),
                  Color(0xFFBBDEFB),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
