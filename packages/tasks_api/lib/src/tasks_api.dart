import 'package:tasks_api/tasks_api.dart';

abstract class TasksApi {
  Future<void> saveTask(TaskModel task);
  Stream<List<TaskModel>> getTasks();
  Future<void> deleteTask(String id);
}

class TaskCouldNotBeSavedException implements Exception {
  final String cause;

  TaskCouldNotBeSavedException(this.cause);
}

class TaskNotFoundException implements Exception {
  final String cause;

  TaskNotFoundException(this.cause);
}
