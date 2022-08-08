part of 'task_view_cubit.dart';

@immutable
abstract class TaskViewState {}

class TaskViewInitial extends TaskViewState {}

class TaskViewAddEditTaskInProgress extends TaskViewState {}

class TaskViewAddEditTaskSubmitting extends TaskViewState {}

class TaskViewAddEditSuccess extends TaskViewState {
  final TaskModel taskModel;

  TaskViewAddEditSuccess(this.taskModel);
}

class TaskViewAddEditTaskAbort extends TaskViewState {}

class TaskViewAddEditStepInProgress extends TaskViewState {}

class TaskViewAddEditStepSubmitting extends TaskViewState {}

class TaskViewAddEditStepAbort extends TaskViewState {}
