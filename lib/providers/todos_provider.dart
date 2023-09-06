import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knowunity_case_study/io/json_placeholder_api/json_placeholder_api_client.dart';
import 'package:knowunity_case_study/io/json_placeholder_api/live_json_placeholder_api_client.dart';
import 'package:knowunity_case_study/models/todo.dart';

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier({required this.apiClient}) : super([]);

  final JsonPlaceholderApiClient apiClient;

  Future<void> initialize() async {
    final todos = await apiClient.getTodos();
    state = todos;
  }

  Future<void> add(String task) async {
    final todo = await apiClient.addTodo(
      task,
    );
    state = [...state, todo];
  }

  /// Immediately toggles the completed value of the todo with the given [id].
  /// Afterwards sends the update to the server and reverts the change if there's an error and propagates the error.
  Future<void> toggleCompleted(int id) async {
    _localToggleCompleted(id);

    // Send the update to the server after updating the state
    try {
      await apiClient.toggleCompleted(id);
    } catch (error) {
      // If there's an error, revert the change
      _localToggleCompleted(id);
      rethrow;
    }
  }

  void _localToggleCompleted(int id) {
    state = [
      for (final stateTodo in state)
        if (stateTodo.id == id)
          stateTodo.copyWith(completed: !stateTodo.completed)
        else
          stateTodo,
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>(
  (ref) {
    final apiClient = ref.watch(apiClientProvider);
    return TodosNotifier(apiClient: apiClient);
  },
);

final apiClientProvider = Provider<JsonPlaceholderApiClient>(
  (ref) => LiveJsonPlaceholderApiClient(
    userId: '42', // Dummy value for now
  ),
);
