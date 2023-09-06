import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_case_study/providers/todos_provider.dart';
import 'package:knowunity_case_study/screens/add_todo_screen.dart';
import 'package:knowunity_case_study/widgets/new_todo_button.dart';
import 'package:knowunity_case_study/widgets/todo_list.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: .0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            thickness: 1.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: NewTodoButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AddTodoScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.read(todosProvider.notifier).initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const TodoList();
        },
      ),
    );
  }
}
