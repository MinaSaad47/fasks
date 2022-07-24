import 'package:fasks/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PomodoroView extends StatelessWidget {
  const PomodoroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: 'Pomodoro'),
    );
  }
}
