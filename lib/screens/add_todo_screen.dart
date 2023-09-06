import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_case_study/providers/todos_provider.dart';
import 'package:knowunity_case_study/widgets/add_todo_button.dart';
import 'package:knowunity_case_study/widgets/add_todo_text_field.dart';
import 'package:knowunity_case_study/widgets/scaffold_with_loading_overlay.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends ConsumerState<AddTodoScreen>
    with SingleTickerProviderStateMixin {
  bool _isPublishingTodo = false;
  late final _textEditingController = TextEditingController();
  late final _buttonAnimationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 2.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _buttonAnimationController,
    curve: Curves.easeOutQuart,
  ));

  @override
  void dispose() {
    _textEditingController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  Future<void> addTodo() async {
    setState(() {
      _isPublishingTodo = true;
    });
    await ref.read(todosProvider.notifier).add(_textEditingController.text);
    setState(() {
      _isPublishingTodo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithLoadingOverlay(
      isLoading: _isPublishingTodo,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddTodoTextField(
                controller: _textEditingController,
                onHasTextChange: (hasText) {
                  if (hasText) {
                    _buttonAnimationController.forward();
                  } else {
                    _buttonAnimationController.reverse();
                  }
                },
              ),
              const Spacer(),
              SafeArea(
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: AddTodoButton(
                    onPressed: () {
                      // Don't perform actions if button is pressed during animation.
                      if (_buttonAnimationController.isCompleted) {
                        addTodo().then((_) {
                          Navigator.of(context).pop();
                        }).catchError(
                          (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
