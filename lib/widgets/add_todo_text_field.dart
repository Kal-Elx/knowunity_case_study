import 'package:flutter/material.dart';

class AddTodoTextField extends StatefulWidget {
  const AddTodoTextField({
    super.key,
    this.controller,
    this.onHasTextChange,
  });

  final TextEditingController? controller;
  final void Function(bool hasText)? onHasTextChange;

  @override
  State<AddTodoTextField> createState() => _AddTodoTextFieldState();
}

class _AddTodoTextFieldState extends State<AddTodoTextField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(hasTextListener);
  }

  @override
  void dispose() {
    _controller.removeListener(hasTextListener);

    // Only dispose the controller if it was created in this widget.
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  void hasTextListener() {
    final newHasText = _controller.text.isNotEmpty;
    if (newHasText != _hasText) {
      widget.onHasTextChange?.call(newHasText);
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What do you need to do?',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: _controller,
          autofocus: true,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Feed the cat...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.all(16.0),
            fillColor: theme.colorScheme.primary.withOpacity(0.5),
          ),
          maxLines: 6,
        ),
      ],
    );
  }
}
