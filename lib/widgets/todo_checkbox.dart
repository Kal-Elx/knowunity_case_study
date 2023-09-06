import 'package:flutter/material.dart';

class TodoCheckbox extends StatelessWidget {
  const TodoCheckbox({
    super.key,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  final bool isCompleted;
  final void Function(bool isCompleted) onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: theme.colorScheme.inversePrimary,
        checkColor: theme.colorScheme.primary,
        value: isCompleted,
        onChanged: (value) {
          onCheckboxChanged(value!);
        },
        side: BorderSide(
          width: 2.0,
          color: theme.colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
