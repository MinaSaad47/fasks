import 'package:tasks_api/tasks_api.dart';

class TasksRepository {
  final TasksApi tasksApi;

  late Stream<List<TaskModel>> allTasks;
  late Stream<List<TaskModel>> dayTasks;
  late Stream<List<TaskModel>> weekTasks;
  late Stream<List<TaskModel>> monthTasks;

  TasksRepository(this.tasksApi);

  void loadTasks() {
    allTasks = tasksApi.getTasks();
    dayTasks = allTasks.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inHours < 24;
      }).toList(),
    );
    weekTasks = allTasks.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inHours >= 24 ||
            task.finishDate.difference(DateTime.now()).inDays < 7;
      }).toList(),
    );
    monthTasks = allTasks.map(
      (list) => list.where((task) {
        return task.finishDate.difference(DateTime.now()).inDays >= 7 ||
            task.finishDate.difference(DateTime.now()).inDays < 30;
      }).toList(),
    );
  }

  Future saveTask(TaskModel task) async => await tasksApi.saveTask(task);
  Future deleteTask(String id) async => await tasksApi.deleteTask(id);
}
