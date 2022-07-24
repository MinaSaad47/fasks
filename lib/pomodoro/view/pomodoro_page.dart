import 'package:fasks/pomodoro/pomodoro.dart';
import 'package:flutter/material.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(
        builder: (context) => const PomodoroPage(),
      );

  @override
  Widget build(BuildContext context) {
    return const PomodoroView();
  }
}
