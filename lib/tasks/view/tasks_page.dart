import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_repository/tasks_repository.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const TasksPage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TasksCubit(context.read<TasksRepository>())..getTasks(),
      child: const TasksView(),
    );
  }
}
