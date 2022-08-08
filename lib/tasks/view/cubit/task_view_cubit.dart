import 'package:bloc/bloc.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'task_view_state.dart';

class TaskViewCubit extends Cubit<TaskViewState> {
  TaskViewCubit() : super(TaskViewInitial());

  void addOrEditTask(BuildContext context, {TaskModel? task}) {
    emit(TaskViewAddEditTaskInProgress());
    Scaffold.of(context)
        .showBottomSheet((context) => AddEditTaskSheet(task))
        .closed
        .then(
          (value) => emit(TaskViewAddEditTaskAbort()),
        );
  }

  void submitTask() {
    emit(TaskViewAddEditTaskSubmitting());
  }

  void saveTask(BuildContext context, TaskModel taskModel) {
    Navigator.of(context).pop();
    emit(TaskViewAddEditSuccess(taskModel));
  }

  void addOrEditStep(BuildContext context, TaskModel task, {StepModel? step}) {
    emit(TaskViewAddEditStepInProgress());
    Scaffold.of(context)
        .showBottomSheet((context) => AddEditStepSheet(task, step: step))
        .closed
        .then(
          (value) => emit(TaskViewAddEditStepAbort()),
        );
  }

  void submitStep() {
    emit(TaskViewAddEditStepSubmitting());
  }
}
