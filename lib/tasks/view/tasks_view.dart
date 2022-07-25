import 'package:fasks/tasks/tasks.dart';
import 'package:fasks/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      appBar: PageAppBar(title: 'Tasks'),
      drawer: const NavigationDrawer(),
      body: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is TasksPageChange) {
            pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubicEmphasized,
            );
          } else if (state is TasksAddBottomSheetOpen) {
            showBottomSheet(
              context: context,
              builder: (context) => const AddBottomSheet() /**/,
            ).closed.then((value) {
              if (context.read<TasksCubit>().isBotSheetActive) {
                context.read<TasksCubit>().swipeDownAddBottomSheet();
              }
            });
          } else if (state is TasksAddBottomSheetClose) {
            Navigator.of(context).pop();
          }
        },
        buildWhen: (current, next) => next is TasksPageChange,
        builder: (context, state) {
          return PageView.builder(
            controller: pageController,
            itemBuilder: (context, index) => Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).colorScheme.background.withAlpha(86),
              ),
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text('Page'),
              ),
            ),
            itemCount: 5,
            onPageChanged: (index) {
              context.read<TasksCubit>().changeActiveBotNavItem(index);
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              bool isBottomSheetActive =
                  context.read<TasksCubit>().isBotSheetActive;
              return FloatingActionButton(
                onPressed: isBottomSheetActive
                    ? () {
                        context.read<TasksCubit>().submitAddBottomSheet();
                      }
                    : () {
                        context.read<TasksCubit>().openAddBottomSheet();
                      },
                child: Icon(
                  isBottomSheetActive
                      ? Icons.check_outlined
                      : Icons.add_outlined,
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              BottomNavigationButton(
                text: 'Tasks',
                icon: Icons.task,
                index: 0,
              ),
              BottomNavigationButton(
                text: 'Day',
                icon: Icons.calendar_view_day_outlined,
                index: 1,
              ),
              BottomNavigationButton(
                text: 'Week',
                icon: Icons.calendar_view_week_outlined,
                index: 2,
              ),
              BottomNavigationButton(
                text: 'Month',
                icon: Icons.calendar_view_month_outlined,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
