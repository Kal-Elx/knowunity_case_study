import 'package:knowunity_case_study/models/todo.dart';

abstract class JsonPlaceholderApiClient {
  JsonPlaceholderApiClient({
    required this.userId,
  });

  final String userId;

  Future<List<Todo>> getTodos();

  Future<Todo> addTodo(String task);

  Future<void> toggleCompleted(int id);
}
