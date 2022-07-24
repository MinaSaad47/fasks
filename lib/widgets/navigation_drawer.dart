import 'package:fasks/pomodoro/pomodoro.dart';
import 'package:fasks/settings/settings.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:fasks/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              DrawerItem(
                text: 'Tasks',
                icon: Icons.task_outlined,
                route: TasksPage.route(),
              ),
              DrawerItem(
                text: 'Pomodoro',
                icon: Icons.emoji_food_beverage_outlined,
                route: PomodoroPage.route(),
              ),
              const Divider(thickness: 2),
              DrawerItem(
                text: 'Settings',
                icon: Icons.settings_outlined,
                route: SettingsPage.route(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
