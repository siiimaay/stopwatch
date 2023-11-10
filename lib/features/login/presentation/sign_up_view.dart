import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stopwatch/features/login/presentation/common_widgets/form_field_label.dart';
import 'package:stopwatch/routes/route_config.dart';
import 'package:stopwatch/widgets/action_button.dart';

import 'common_widgets/text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.indigo,
            onPressed: () =>
                GoRouter.of(context).pushNamed(AppRouter.authRoute)),
        centerTitle: true,
        title: const Text(
          "Sign-up",
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
            ),
            const FormFieldLabel(label: 'Username'),
            Flexible(
                child: AuthTextField(
              controller: _userNameController,
            )),
            const FormFieldLabel(label: 'Password'),
            Flexible(
                child: AuthTextField(
              controller: _passwordController,
            )),
            const FormFieldLabel(label: 'Country'),
            Flexible(
                child: AuthTextField(
              controller: _countryController,
            )),
            const FormFieldLabel(label: 'Phone'),
            Flexible(child: AuthTextField(controller: _phoneNumberController)),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ActionButton(
                buttonText: 'Create Account',
                onPressed: () {},
                textColor: Colors.indigo,
                buttonSize: Size(200, 45),
                gradient: LinearGradient(colors: [
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
