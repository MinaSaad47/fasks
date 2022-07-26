import 'package:tasks_api/tasks_api.dart';

abstract class TaskApi {
  Future<void> createTask(Task task);
  Stream<List<Task>> readTasks();
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
}
