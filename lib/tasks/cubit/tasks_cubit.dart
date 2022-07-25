import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  bool isBotSheetActive = false;

  void changePage(int index) {
    emit(TasksPageChange(index));
  }

  void changeActiveBotNavItem(int index) {
    emit(TasksActiveBotNavItemChange(index));
  }

  void openAddBottomSheet() {
    isBotSheetActive = true;
    emit(TasksAddBottomSheetOpen());
  }

  void swipeDownAddBottomSheet() {
    isBotSheetActive = false;
    emit(TasksAddBottomSheetSwipeDown());
  }

  void closeAddBottomSheet() {
    isBotSheetActive = false;
    emit(TasksAddBottomSheetClose());
  }

  void submitAddBottomSheet() {
    emit(TasksAddBottomSheetSubmit());
  }
}
