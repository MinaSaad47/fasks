part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksPageChange extends TasksState {
  final int currentPage;

  TasksPageChange(this.currentPage);
}
