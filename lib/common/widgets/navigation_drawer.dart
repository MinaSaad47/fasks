import 'package:fasks/common/common.dart';
import 'package:fasks/pomodoro/pomodoro.dart';
import 'package:fasks/settings/settings.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              ListTile(
                title: const Text('About'),
                leading: const Icon(Icons.info_outline),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: Consts.appName,
                    applicationIcon: const FlutterLogo(),
                    applicationVersion: Consts.appVersion,
                    children: [
                      const ListTile(
                        title: Text(Consts.authorName),
                        leading: Icon(Icons.person),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () async {
                          var uri = Uri.parse(Consts.srcUrl);
                          if (await canLaunchUrl(uri)) {
                            launchUrl(uri);
                          }
                        },
                        title: const Text('Source Code'),
                        leading: const Icon(Icons.code),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
