import 'dart:math';

import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tasks_repository/tasks_repository.dart';

class TasksList extends StatelessWidget {
  final List<TaskModel> tasks;
  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.error,
              label: 'Delete',
              onPressed: (context) {
                context.read<TasksCubit>().deleteTask(tasks[index]);
              },
            ),
            SlidableAction(
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: 'Edit',
              onPressed: (context) {
                context
                    .read<TaskViewCubit>()
                    .addOrEditTask(context, task: tasks[index]);
              },
            ),
          ],
        ),
        child: TaskWidget(task: tasks[index]),
      ),
      itemCount: tasks.length,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final TaskModel task;
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isExpanded = false;
  late var task = widget.task;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      leading: const Icon(Icons.task_outlined),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title),
          const SizedBox(height: 5),
          Text(
            '${DateFormat('yMMMMd').format(task.finishDate)}   ${DateFormat('jm').format(task.finishDate)}',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
      children: [
        Text(task.description),
        if (task.steps.isNotEmpty)
          StepsListWidget(
            steps: task.steps,
            onUpdated: (index, step) {
              task.steps[index] = step;
              context.read<TasksCubit>().saveTask(task);
            },
          ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerRight,
            child: _buildAddStepButton(context),
          ),
        )
      ],
    );
  }

  Container _buildAddStepButton(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary.withAlpha(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          context.read<TaskViewCubit>().addOrEditStep(context, task);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text('Add a step'),
          ],
        ),
      ),
    );
  }
}

class StepsListWidget extends StatefulWidget {
  final List<StepModel> steps;
  final void Function(int index, StepModel step) onUpdated;
  const StepsListWidget({
    Key? key,
    required this.steps,
    required this.onUpdated,
  }) : super(key: key);

  @override
  State<StepsListWidget> createState() => _StepsListWidgetState();
}

class _StepsListWidgetState extends State<StepsListWidget> {
  late var steps = widget.steps;
  late var currentStep = steps.indexWhere((step) => !step.isCompleted);
  @override
  Widget build(BuildContext context) {
    return Stepper(
      // the key is just a work around `steps.length == oldSteps.length not true`
      // TODO: find a fix (as it disables the animations)
      key: Key(Random.secure().nextDouble().toString()),
      physics: const NeverScrollableScrollPhysics(),
      controlsBuilder: (context, details) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (currentStep < steps.length - 1)
            MaterialButton(
              onPressed: details.onStepContinue,
              color: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.done),
            ),
          const SizedBox(width: 10),
          if (currentStep > 0)
            MaterialButton(
              onPressed: details.onStepCancel,
              color: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.backspace_outlined),
            )
        ],
      ),
      currentStep: currentStep,
      onStepTapped: (index) {},
      onStepCancel: () {
        setState(() {
          widget.onUpdated(
            currentStep,
            steps[currentStep].copyWith(isCompleted: false),
          );
          currentStep--;
        });
      },
      onStepContinue: () {
        setState(() {
          steps[currentStep] = steps[currentStep].copyWith(isCompleted: true);
          widget.onUpdated(
            currentStep,
            steps[currentStep].copyWith(isCompleted: true),
          );
          currentStep++;
        });
      },
      steps: List.generate(
        steps.length,
        (index) => StepWidget(steps[index], isDone: index < currentStep),
      ),
    );
  }
}

class StepWidget extends Step {
  StepWidget(StepModel step, {bool isDone = false})
      : super(
          title: Text(
            step.description,
            style: isDone
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          content: const Text(''),
          state: step.isCompleted ? StepState.complete : StepState.indexed,
          isActive: step.isCompleted,
        );
}
