import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasksRepository) : super(const TasksState());

  final TasksRepository _tasksRepository;

  bool isBotSheetActive = false;

  void getTasks() {
    emit(state.copyWith(status: TasksStatus.loading));
    _tasksRepository.loadTasks();

    _tasksRepository.allTasks.forEach((tasks) {
      emit(state.copyWith(status: TasksStatus.success, allTasks: tasks));
    }).catchError((e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    });

    _tasksRepository.dayTasks.forEach((tasks) {
      emit(state.copyWith(status: TasksStatus.success, dayTasks: tasks));
    }).catchError((e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    });

    _tasksRepository.weekTasks.forEach((tasks) {
      emit(state.copyWith(status: TasksStatus.success, weekTasks: tasks));
    }).catchError((e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    });

    _tasksRepository.monthTasks.forEach((tasks) {
      emit(state.copyWith(status: TasksStatus.success, monthTasks: tasks));
    }).catchError((e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    });
  }

  Future saveTask(TaskModel task) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      await _tasksRepository.saveTask(task);
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  Future deleteTask(TaskModel task) async {
    emit(state.copyWith(status: TasksStatus.loading));
    try {
      await _tasksRepository.deleteTask(task.id);
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }
}
