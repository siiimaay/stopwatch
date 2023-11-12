import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:stopwatch/features/auth/presentation/common_widgets/form_field_label.dart';
import 'package:stopwatch/routes/route_config.dart';
import 'package:stopwatch/widgets/action_button.dart';
import 'package:stopwatch/widgets/snackbar.dart';

import '../domain/sign_up_cubit.dart';
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
      body: BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(),
        child: Builder(builder: (context) {
          return BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              final event = state.registerEvent;
              if (event is SuccessfulRegister) {
                GoRouter.of(context).go('/${AppRouter.loginRoute}');
              } else if (event is FailedRegister) {
                Navigator.of(context).pop();
                TopSnackBarOverlay.showTopSnackbar(
                  context: context,
                  message: 'Something went wrong, please try again',
                  backgroundColor: Colors.red,
                  icon: Icons.error,
                );
              } else if (event is LoadingEvent) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child:
                          Lottie.asset('assets/animations/loading_timer.json'),
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
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
                    const SizedBox(height: 20),
                    const FormFieldLabel(label: 'Username'),
                    Flexible(
                        child: AuthTextField(
                      controller: _userNameController,
                    )),
                    const FormFieldLabel(label: 'Password'),
                    Flexible(
                        child: AuthTextField(
                      controller: _passwordController,
                      isObscure: true,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          if (number.isoCode != null) {
                            _countryController.text = number.isoCode!;
                          }
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        textFieldController: _phoneNumberController,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        searchBoxDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.indigo,
                              width: 1.5,
                            ),
                          ),
                        ),
                        inputDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.indigo,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: ActionButton(
                        buttonText: 'Create Account',
                        onPressed: () {
                          _cubit(context).createAccount(
                            _userNameController.text,
                            _passwordController.text,
                            _phoneNumberController.text,
                            _countryController.text,
                          );
                        },
                        textColor: Colors.indigo,
                        buttonSize: const Size(200, 45),
                        gradient: const LinearGradient(colors: [
                          Color(0xFFD1C4E9),
                          Color(0xFFBBDEFB),
                        ]),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  SignUpCubit _cubit(context) => BlocProvider.of<SignUpCubit>(context);
}
