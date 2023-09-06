import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48.0),
      ),
      onPressed: onPressed,
      child: Text(
        'Add to list',
        style: theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
