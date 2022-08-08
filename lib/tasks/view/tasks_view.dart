import 'package:fasks/common/widgets/widgets.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    var taskSaveNotifier = ValueNotifier<bool>(false);
    return Scaffold(
      appBar: PageAppBar(
        title: const ListTile(
          title: Text('Tasks'),
          trailing: Icon(Icons.task_outlined),
        ),
      ),
      drawer: const NavigationDrawer(),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TasksList(tasks: state.allTasks),
              TasksList(tasks: state.dayTasks),
              TasksList(tasks: state.weekTasks),
              TasksList(tasks: state.monthTasks),
            ],
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder(
        builder: (context, value, child) => const AddEditActionButtonWidget(),
        valueListenable: taskSaveNotifier,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut,
          );
        },
        items: [
          BottomNavigationBarItemWidget(
            label: 'All',
            icon: Icons.task_outlined,
          ),
          BottomNavigationBarItemWidget(
            label: 'Day',
            icon: Icons.calendar_view_day_outlined,
          ),
          BottomNavigationBarItemWidget(
            label: 'Week',
            icon: Icons.calendar_view_week_outlined,
          ),
          BottomNavigationBarItemWidget(
            label: 'Month',
            icon: Icons.calendar_view_month_outlined,
          ),
        ],
      ),
    );
  }
}

class AddEditActionButtonWidget extends StatefulWidget {
  const AddEditActionButtonWidget({Key? key}) : super(key: key);

  @override
  State<AddEditActionButtonWidget> createState() =>
      AddEditActionButtonWidgetState();
}

class AddEditActionButtonWidgetState extends State<AddEditActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskViewCubit, TaskViewState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            if (state is TaskViewAddEditTaskInProgress ||
                state is TaskViewAddEditTaskSubmitting) {
              context.read<TaskViewCubit>().submitTask();
            } else if (state is TaskViewAddEditStepInProgress ||
                state is TaskViewAddEditStepSubmitting) {
              context.read<TaskViewCubit>().submitStep();
            } else {
              context.read<TaskViewCubit>().addOrEditTask(context);
            }
          },
          child: Icon(
            state is TaskViewAddEditTaskInProgress ||
                    state is TaskViewAddEditTaskSubmitting
                ? Icons.done
                : Icons.add,
          ),
        );
      },
    );
  }
}
