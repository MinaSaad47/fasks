part of 'tasks_cubit.dart';

@immutable
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksPageChange extends TasksState {
  final int currentPage;

  TasksPageChange(this.currentPage);
}

class TasksActiveBotNavItemChange extends TasksState {
  final int currentItem;

  TasksActiveBotNavItemChange(this.currentItem);
}

class TasksAddBottomSheetOpen extends TasksState {}

class TasksAddBottomSheetClose extends TasksState {}

class TasksAddBottomSheetSwipeDown extends TasksState {}

class TasksAddBottomSheetSubmit extends TasksState {}
