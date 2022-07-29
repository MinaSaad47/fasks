import 'package:fasks/common/widgets/widgets.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: PageAppBar(
        title: const ListTile(
          title: Text('Tasks'),
          trailing: Icon(Icons.task_outlined),
        ),
      ),
      drawer: const NavigationDrawer(),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          // TODO: implement listener
        },
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
      floatingActionButton: const AddActionButton(),
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

class AddActionButton extends StatefulWidget {
  const AddActionButton({Key? key}) : super(key: key);

  @override
  State<AddActionButton> createState() => _AddActionButtonState();
}

class _AddActionButtonState extends State<AddActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (!isPressed) {
          setState(() {
            isPressed = true;
          });
          Scaffold.of(context)
              .showBottomSheet((context) => const AddBottomSheet())
              .closed
              .then((value) {
            setState(() {
              isPressed = false;
            });
          });
        }
      },
      child: Icon(isPressed ? Icons.done : Icons.add_outlined),
    );
  }
}
