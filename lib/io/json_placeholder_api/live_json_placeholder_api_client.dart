import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knowunity_case_study/io/json_placeholder_api/json_placeholder_api_client.dart';
import 'package:knowunity_case_study/models/todo.dart';
import 'package:path/path.dart' as path;

const _url = 'https://jsonplaceholder.typicode.com/todos';

class LiveJsonPlaceholderApiClient extends JsonPlaceholderApiClient {
  LiveJsonPlaceholderApiClient({
    required super.userId,
  }) : httpClient = http.Client();

  final http.Client httpClient;

  @override
  Future<List<Todo>> getTodos() async {
    final response = await httpClient.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> postsJson = jsonDecode(response.body);
      return postsJson.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching todos');
    }
  }

  @override
  Future<Todo> addTodo(String task) async {
    final response = await httpClient.post(
      Uri.parse(_url),
      body: jsonEncode({
        'userId': userId,
        'title': task,
        'completed': false,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return Todo(
        id: json['id'],
        title: task,
        completed: false,
      );
    } else {
      throw Exception('Error adding todo');
    }
  }

  @override
  Future<void> toggleCompleted(int id) async {
    final response = await httpClient.put(
      Uri.parse(path.join(_url, id.toString())),
      body: jsonEncode({
        'completed': true,
      }),
    );

    if (response.statusCode != 200) {
      //! Will fail for todos created by the user because they are not actually stored on the server.
      throw Exception('Error toggling completed in todo');
    }
  }
}
