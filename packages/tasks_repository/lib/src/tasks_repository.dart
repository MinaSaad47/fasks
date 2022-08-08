import 'package:tasks_api/tasks_api.dart';

class TasksRepository {
  final TasksApi tasksApi;

  late Stream<List<TaskModel>> allTasks;
  late Stream<List<TaskModel>> dayTasks;
  late Stream<List<TaskModel>> weekTasks;
  late Stream<List<TaskModel>> monthTasks;

  TasksRepository(this.tasksApi);

  void loadTasks() {
    final stream = tasksApi.getTasks().asBroadcastStream();
    allTasks = stream;
    dayTasks = stream.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inHours < 24;
      }).toList(),
    );
    weekTasks = stream.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inHours >= 24 ||
            task.finishDate.difference(DateTime.now()).inDays < 7;
      }).toList(),
    );
    monthTasks = stream.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inDays >= 7 ||
            task.finishDate.difference(DateTime.now()).inDays < 30;
      }).toList(),
    );
  }

  Future saveTask(TaskModel task) async => await tasksApi.saveTask(task);
  Future deleteTask(String id) async => await tasksApi.deleteTask(id);
}
