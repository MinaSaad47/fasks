import 'package:fasks/tasks/cubit/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationButton extends StatelessWidget {
  final String text;
  final int index;
  final IconData icon;

  const BottomNavigationButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      bool isSelected = context.select(
        (TasksCubit cubit) => cubit.state is TasksActiveBotNavItemChange
            ? (cubit.state as TasksActiveBotNavItemChange).currentItem == index
            : false,
      );
      Color? color = isSelected
          ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
          : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
      TextStyle? style = isSelected
          ? Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle
          : Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle;
      return MaterialButton(
        color: isSelected && color != null ? color.withOpacity(0.3) : null,
        onPressed: () {
          context.read<TasksCubit>().changePage(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(text, style: style),
          ],
        ),
      );
    });
  }
}
