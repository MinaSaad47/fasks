import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tasks_api/tasks_api.dart';

class SqliteDbTasksApi extends TasksApi {
  @visibleForTesting
  late final Database database;
  final _tasksStreamController =
      BehaviorSubject<List<TaskModel>>.seeded(const []);

  SqliteDbTasksApi._internal(Database db) : database = db;

  static Future instance(String dbPath) async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    var db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON');
        await db.execute('''
          CREATE TABLE tasks (
            id TEXT PRIMARY KEY NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            is_completed BOOL NOT NULL,
            created_date TEXT NOT NULL,
            finish_date TEXT NOT NULL
          );
        ''');
        await db.execute('''
            CREATE TABLE steps (
            id TEXT PRIMARY KEY NOT NULL,
            description TEXT NOT NULL,
            is_completed BOOL NOT NULL,
            task_id INTEGER REFERENCES tasks(id) ON DELETE CASCADE
            );
          ''');
      },
    );
    var instance = SqliteDbTasksApi._internal(db);
    await instance._emitTasks();
    return instance;
  }

  @override
  Stream<List<TaskModel>> getTasks() => _tasksStreamController.stream;

  @override
  Future<void> deleteTask(String id) async {
    final tasks = [..._tasksStreamController.value];
    int index = tasks.indexWhere((element) => element.id == id);
    if (index < 0) {
      throw TaskNotFoundException('Task not found');
    }
    var db = database;
    int deleted = await db.transaction((txn) async {
      int stepsDeleted = await txn.delete(
        'steps',
        where: 'task_id = ?',
        whereArgs: [id],
      );

      if (stepsDeleted < 0) return stepsDeleted;

      int tasksDeleted = await txn.delete(
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
  Future<void> saveTask(TaskModel task) async {
    final tasks = [..._tasksStreamController.value];
    var db = database;
    try {
      await db.transaction((txn) async {
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

      var index = tasks.indexWhere((element) => element.id == task.id);
      if (index >= 0) {
        tasks[index] = task;
      } else {
        tasks.add(task);
      }
      _tasksStreamController.add(tasks);
    } catch (e, st) {
      throw Error.throwWithStackTrace(
        TaskCouldNotBeSavedException(e.toString()),
        st,
      );
    }
  }

  Future _emitTasks() async {
    var taskMapList = await database.query('tasks');
    var tasksFuture = taskMapList.map((rawTask) async {
      Map<String, dynamic> taskMap = Map.from(rawTask);
      taskMap['steps'] = await database.query(
        'steps',
        columns: ['id', 'description', 'is_completed'],
        where: 'task_id = ?',
        whereArgs: [taskMap['id']],
      );
      return TaskModel.fromJson(taskMap);
    });
    var tasks = await Future.wait(tasksFuture);
    _tasksStreamController.sink.add(tasks);
  }
}
