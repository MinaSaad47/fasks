import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void changePage(int index) {
    emit(TasksPageChange(index));
  }
}
