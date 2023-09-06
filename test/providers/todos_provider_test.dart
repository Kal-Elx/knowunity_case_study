import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:knowunity_case_study/io/json_placeholder_api/mock_json_placeholder_api_client.dart';
import 'package:knowunity_case_study/models/todo.dart';
import 'package:knowunity_case_study/providers/todos_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(
    () {
      container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWithValue(
            MockJsonPlaceholderApiClient(
              userId: '42',
            ),
          )
        ],
      );
    },
  );

  group(
    'fetch all todos',
    () {
      test(
        'before initializing',
        () async {
          expect(
            container.read(todosProvider),
            [],
          );
        },
      );

      test(
        'after initialization',
        () async {
          await container.read(todosProvider.notifier).initialize();
          expect(
            container.read(todosProvider),
            MockJsonPlaceholderApiClient.data,
          );
        },
      );
    },
  );

  test(
    'add a todo',
    () async {
      const task = 'New todo';

      await container.read(todosProvider.notifier).initialize();
      await container.read(todosProvider.notifier).add(task);
      expect(
        container.read(todosProvider),
        [
          ...MockJsonPlaceholderApiClient.data,
          const Todo(
            id: task.length * 7,
            title: task,
            completed: false,
          ),
        ],
      );
    },
  );

  group(
    'toggle a todo',
    () {
      setUp(
        () async {
          await container.read(todosProvider.notifier).initialize();
        },
      );

      test(
        'to not completed',
        () async {
          await container.read(todosProvider.notifier).toggleCompleted(0);
          expect(
            container.read(todosProvider),
            [
              for (final todo in MockJsonPlaceholderApiClient.data)
                if (todo.id == 0) todo.copyWith(completed: false) else todo,
            ],
          );
        },
      );

      test(
        'to completed',
        () async {
          await container.read(todosProvider.notifier).toggleCompleted(1);
          expect(
            container.read(todosProvider),
            [
              for (final todo in MockJsonPlaceholderApiClient.data)
                if (todo.id == 1) todo.copyWith(completed: true) else todo,
            ],
          );
        },
      );
    },
  );
}
