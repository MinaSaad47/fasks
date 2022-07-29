import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this._tasksRepository) : super(const TasksState());

  final TasksRepository _tasksRepository;

  bool isBotSheetActive = false;

  Future getTasks() async {
    emit(state.copyWith(status: TasksStatus.loading));
    _tasksRepository.loadTasks();
    try {
      await for (var tasks in _tasksRepository.allTasks) {
        emit(state.copyWith(status: TasksStatus.success, allTasks: tasks));
      }
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
    try {
      await for (var tasks in _tasksRepository.dayTasks) {
        emit(state.copyWith(status: TasksStatus.success, dayTasks: tasks));
      }
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
    try {
      await for (var tasks in _tasksRepository.weekTasks) {
        emit(state.copyWith(status: TasksStatus.success, weekTasks: tasks));
      }
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
    try {
      await for (var tasks in _tasksRepository.monthTasks) {
        emit(state.copyWith(status: TasksStatus.success, monthTasks: tasks));
      }
    } catch (e, st) {
      log(e.toString(), error: e, stackTrace: st);
      emit(state.copyWith(status: TasksStatus.failure));
    }
  }

  Future addTask(task) async {
    await _tasksRepository.saveTask(task);
  }
}
