import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_db_tasks_api/sqlite_db_tasks_api.dart';
import 'package:tasks_api/tasks_api.dart';

Future main() async {
  Directory dir = await getTemporaryDirectory();
  String dbPath = join(dir.path, 'tasks.db');
  group('SqliteDbTasksApi', () {
    group('constructor', () {
      test('works good', () {
        expect(() => SqliteDbTasksApi(path: dbPath), returnsNormally);
      });
    });
    group('crud operations', () {
      final SqliteDbTasksApi sqliteDbTasksApi = SqliteDbTasksApi(path: dbPath);
      test('save first task', () async {
        var task = Task(
          title: 'task',
          description: 'task desc',
          createdDate: DateTime.now(),
          finishDate: DateTime.now(),
        );
        await sqliteDbTasksApi.saveTask(task);
        var savedTasks = await sqliteDbTasksApi.getTasks().skip(0).first;
        expect(savedTasks.first, task);
      });
    });
  });
}
