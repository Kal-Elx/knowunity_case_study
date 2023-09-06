import 'package:knowunity_case_study/io/json_placeholder_api/json_placeholder_api_client.dart';
import 'package:knowunity_case_study/models/todo.dart';

class MockJsonPlaceholderApiClient extends JsonPlaceholderApiClient {
  MockJsonPlaceholderApiClient({
    required super.userId,
  });

  static List<Todo> get data => [
        for (int i = 0; i < 10; i++)
          Todo(
            id: i,
            title: 'Todo $i',
            completed: i % 2 == 0,
          ),
      ];

  @override
  Future<List<Todo>> getTodos() async {
    return data;
  }

  @override
  Future<Todo> addTodo(String task) async {
    return Todo(
      id: task.length * 7,
      title: task,
      completed: false,
    );
  }

  @override
  Future<void> toggleCompleted(int id) async {}
}
