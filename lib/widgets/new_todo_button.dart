import 'package:flutter/material.dart';

class NewTodoButton extends StatelessWidget {
  const NewTodoButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: const Text('New Todo'),
    );
  }
}
