import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_db_tasks_api/sqlite_db_tasks_api.dart';
import 'package:tasks_api/tasks_api.dart';
import 'package:uuid/uuid.dart';

final Task task1 = Task(
  title: 'task1',
  description: 'task1 desc',
  createdDate: DateTime.now(),
  finishDate: DateTime.now(),
  steps: [
    Step(description: 'step1 desc'),
    Step(description: 'step1 desc'),
    Step(description: 'step1 desc'),
  ],
);

final Task task2 = Task(
  title: 'task2',
  description: 'task2 desc',
  createdDate: DateTime.now(),
  finishDate: DateTime.now(),
);

final Task task3 = Task(
  title: 'task3',
  description: 'task3 desc',
  createdDate: DateTime.now(),
  finishDate: DateTime.now(),
);

Future main() async {
  Directory dir = await getTemporaryDirectory();
  group('SqliteDbTasksApi', () {
    String dbPath = join(dir.path, 'sqlite_db_task_api${const Uuid().v4()}.db');
    group('constructor', () {
      test('works good', () {
        expect(() => SqliteDbTasksApi(path: dbPath), returnsNormally);
      });
    });
    late SqliteDbTasksApi sqliteDbTasksApi;
    setUp(() {
      String dbPath =
          join(dir.path, 'sqlite_db_task_api${const Uuid().v4()}.db');
      sqliteDbTasksApi = SqliteDbTasksApi(path: dbPath);
    });
    group('crud operations', () {
      group('create operation', () {
        test('save one task', () async {
          await sqliteDbTasksApi.saveTask(task1);
          expect(sqliteDbTasksApi.getTasks(), emits([task1]));
        });
        test('save multiple tasks', () async {
          var taskStream = sqliteDbTasksApi.getTasks();
          await sqliteDbTasksApi.saveTask(task2);
          await sqliteDbTasksApi.saveTask(task3);
          expect(taskStream, emits([task2, task3]));
        });
      });
      group('delete operation', () {
        test('remove one task', () async {
          var taskStream = sqliteDbTasksApi.getTasks();
          await sqliteDbTasksApi.saveTask(task1);
          await sqliteDbTasksApi.saveTask(task2);
          await sqliteDbTasksApi.saveTask(task3);
          await sqliteDbTasksApi.deleteTask(task1.id);
          expect(taskStream, emits([task2, task3]));
        });
        test('remove all tasks', () async {
          await sqliteDbTasksApi.saveTask(task2);
          await sqliteDbTasksApi.saveTask(task3);
          await sqliteDbTasksApi.deleteTask(task2.id);
          await sqliteDbTasksApi.deleteTask(task3.id);
          expect(sqliteDbTasksApi.getTasks(), emits(const <List<Task>>[]));
        });
      });
      group('update operation', () {
        test('update one task', () async {
          await sqliteDbTasksApi.saveTask(task1);
          await sqliteDbTasksApi.saveTask(task2);
          await sqliteDbTasksApi.saveTask(task3);
          var updatedTask1 = task1.copyWith(title: 'update task1');
          await sqliteDbTasksApi.saveTask(updatedTask1);
          expect(
            sqliteDbTasksApi.getTasks(),
            emits([updatedTask1, task2, task3]),
          );
        });
        test('update multiple tasks', () async {
          await sqliteDbTasksApi.saveTask(task1);
          await sqliteDbTasksApi.saveTask(task2);
          await sqliteDbTasksApi.saveTask(task3);
          var updatedTask1 = task1.copyWith(
            steps: [
              Step(description: 'updated step1'),
              Step(description: 'updated step1'),
            ],
          );
          var updatedTask2 = task2.copyWith(createdDate: DateTime.now());
          await sqliteDbTasksApi.saveTask(updatedTask2);
          await sqliteDbTasksApi.saveTask(updatedTask1);
          expect(
            sqliteDbTasksApi.getTasks(),
            emits([updatedTask1, updatedTask2, task3]),
          );
        });
      });
    });
  });
}
