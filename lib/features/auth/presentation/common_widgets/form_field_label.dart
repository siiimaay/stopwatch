import 'package:flutter/material.dart';

class FormFieldLabel extends StatelessWidget {
  final String label;
  const FormFieldLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.indigo, fontWeight: FontWeight.w600),
      ),
    );
  }
}
