import 'package:fasks/common/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Consts {
  static const String appName = 'Fasks';
  static const String appVersion = '0.1';
  static const String authorName = 'MinaSaad47';
  static const String srcUrl = 'https://github.com/MinaSaad47/fasks/';

  static const List<PageTitle> pagesTitle = [
    PageTitle(
      title: 'All Tasks',
      subtitle: 'Includes tasks of the day, week, month, ...',
      icon: Icons.task_outlined,
    ),
    PageTitle(
      title: 'Day',
      subtitle: 'Includes tasks of this day',
      icon: Icons.calendar_view_day_outlined,
    ),
    PageTitle(
      title: 'Week',
      subtitle: 'Includes tasks of this week',
      icon: Icons.calendar_view_week_outlined,
    ),
    PageTitle(
      title: 'Month',
      subtitle: 'Includes tasks of this month',
      icon: Icons.calendar_view_month_outlined,
    ),
  ];
}
