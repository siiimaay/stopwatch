import 'package:flutter/material.dart';
import 'package:stopwatch/core/extensions/input_validator_extension.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final String? Function(String?)? validator;

  const InputTextField({
    Key? key,
    required this.controller,
    this.isObscure = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.grey,
        obscureText: isObscure,
        validator: (value) {
          return controller.text.isValidField();
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
