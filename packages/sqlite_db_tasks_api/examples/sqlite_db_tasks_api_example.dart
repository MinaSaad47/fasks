import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_db_tasks_api/sqlite_db_tasks_api.dart';
import 'package:tasks_api/tasks_api.dart';

Future main() async {
  var dir = await getApplicationDocumentsDirectory();
  var dbPath = join(dir.path, 'tasks.db');
  TasksApi tasksApi = SqliteDbTasksApi(path: dbPath);
  var task = Task(
    title: 'task',
    description: 'task desc',
    createdDate: DateTime.now(),
    finishDate: DateTime.now(),
  );
  await tasksApi.saveTask(task);
  var savedTask = await tasksApi.getTasks().skip(0).first;
  print(savedTask);
}
