import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_case_study/providers/todos_provider.dart';
import 'package:knowunity_case_study/widgets/todo_list_tile.dart';

class TodoList extends ConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListTile(
          title: todo.title,
          isCompleted: todo.completed,
          onCheckboxChanged: (isCompleted) {
            ref
                .read(todosProvider.notifier)
                .toggleCompleted(todo.id)
                .catchError(
              (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error.toString())),
                );
              },
            );
          },
        );
      },
    );
  }
}
