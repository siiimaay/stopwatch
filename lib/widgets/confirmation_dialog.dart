import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Widget child;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.content,
    required this.child,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: child,
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyle(color: Colors.grey.shade500)),
          onPressed: () {
            onCancel?.call();
            GoRouter.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Proceed',
            style: TextStyle(color: Colors.indigo),
          ),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
