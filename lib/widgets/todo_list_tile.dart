import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:knowunity_case_study/widgets/todo_checkbox.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onCheckboxChanged,
  });

  final String title;
  final bool isCompleted;
  final void Function(bool isCompleted) onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: AnimatedLineThrough(
          duration: const Duration(milliseconds: 200),
          isCrossed: isCompleted,
          child: Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
        ),
        minVerticalPadding: 16.0,
        trailing: TodoCheckbox(
          isCompleted: isCompleted,
          onCheckboxChanged: onCheckboxChanged,
        ),
      ),
    );
  }
}
