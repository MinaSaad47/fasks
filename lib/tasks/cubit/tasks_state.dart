part of 'tasks_cubit.dart';

enum TasksStatus {
  initial,
  loading,
  success,
  failure,
}

class TasksState extends Equatable {
  final TasksStatus status;

  final List<TaskModel> allTasks;
  final List<TaskModel> dayTasks;
  final List<TaskModel> weekTasks;
  final List<TaskModel> monthTasks;

  const TasksState({
    this.status = TasksStatus.initial,
    this.allTasks = const [],
    this.dayTasks = const [],
    this.weekTasks = const [],
    this.monthTasks = const [],
  });

  TasksState copyWith({
    TasksStatus? status,
    List<TaskModel>? allTasks,
    List<TaskModel>? dayTasks,
    List<TaskModel>? weekTasks,
    List<TaskModel>? monthTasks,
  }) =>
      TasksState(
        status: status ?? this.status,
        allTasks: allTasks ?? this.allTasks,
        dayTasks: dayTasks ?? this.dayTasks,
        weekTasks: weekTasks ?? this.weekTasks,
        monthTasks: monthTasks ?? this.monthTasks,
      );

  @override
  List<Object?> get props => [
        status,
        allTasks,
      ];
}
