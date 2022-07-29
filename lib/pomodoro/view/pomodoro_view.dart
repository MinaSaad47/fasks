import 'package:fasks/common/common.dart';
import 'package:flutter/material.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: const PageTitle(
          title: 'Pomodoro',
          subtitle: 'Pomodoro',
          icon: Icons.coffee_outlined,
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
