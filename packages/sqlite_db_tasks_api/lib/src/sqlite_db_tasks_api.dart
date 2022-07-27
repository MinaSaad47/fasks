import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasks_api/tasks_api.dart';

class SqliteDbTasksApi extends TasksApi {
  SqliteDbTasksApi({required String path}) {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _db = openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      PRAGMA foreign_keys = ON;
      CREATE TABLE tasks (
        id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        created_date TEXT NOT NULL,
        finish_date TEXT NOT NULL
      );
      CREATE TABLE steps (
        id TEXT NOT NULL,
        description TEXT NOT NULL,
        task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE
      );
      ''');
      },
      onOpen: (db) async {
        var taskMapList = await db.query('tasks', orderBy: 'created_date ASC');
        var tasksFuture = taskMapList.map((rawTask) async {
          Map<String, dynamic> taskMap = Map.from(rawTask);
          taskMap['steps'] = await db.query(
            'steps',
            columns: ['id', 'description'],
            where: 'task_id = ?',
            whereArgs: [taskMap['id']],
          );
          return Task.fromJson(taskMap);
        });
        var tasks = await Future.wait(tasksFuture);
        _tasksStreamController.sink.add(tasks);
      },
    );
  }

  late final Future<Database> _db;
  final _tasksStreamController = BehaviorSubject<List<Task>>.seeded(const []);

  @override
  Future<void> deleteTask(String id) async {
    final tasks = [..._tasksStreamController.value];
    int index = tasks.indexWhere((element) => element.id == id);
    if (index < 0) {
      throw TaskNotFoundException('Task not found');
    }
    var db = await _db;
    int deleted = await db.transaction((txn) async {
      int stepsDeleted = await db.delete(
        'steps',
        where: 'task_id = ?',
        whereArgs: [id],
      );
      if (stepsDeleted < 0) {
        return -1;
      }
      int tasksDeleted = await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
      return tasksDeleted;
    });
    if (deleted > 0) {
      tasks.removeAt(index);
      _tasksStreamController.add(tasks);
    } else {
      throw TaskNotFoundException('Task not found');
    }
  }

  @override
  Stream<List<Task>> getTasks() {
    return _tasksStreamController.stream.asBroadcastStream();
  }

  @override
  Future<void> saveTask(Task task) async {
    final tasks = [..._tasksStreamController.value];
    var db = await _db;
    try {
      int inserted = await db.transaction((txn) async {
        int taskInserted = await txn.insert(
          'tasks',
          task.toMap()..remove('steps'),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        if (taskInserted < 0) {
          return taskInserted;
        }

        await txn.delete(
          'steps',
          where: 'task_id = ?',
          whereArgs: [task.id],
        );

        for (var step in task.steps) {
          int stepInserted = await txn.insert(
            'steps',
            step.toMap()..addAll({'task_id': task.id}),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          if (stepInserted < 0) {
            return stepInserted;
          }
        }

        return taskInserted;
      });
      if (inserted > 0) {
        tasks.add(task);
      } else if (inserted == 0) {
        var index = tasks.indexWhere((element) => element.id == task.id);
        tasks[index] = task;
      }
      _tasksStreamController.add(tasks);
    } catch (e, st) {
      throw Error.throwWithStackTrace(
        TaskCouldNotBeSavedException(e.toString()),
        st,
      );
    }
  }
}
