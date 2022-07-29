import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_repository/tasks_repository.dart';

class TasksList extends StatefulWidget {
  final List<TaskModel> tasks;
  const TasksList({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late List<bool> isExpanded = List.filled(widget.tasks.length, false);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ExpansionTile(
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded[index] = expanded;
          });
        },
        leading: const Icon(Icons.task_outlined),
        title: Row(
          children: [
            Text(widget.tasks[index].title),
            const Spacer(),
            if (!isExpanded[index])
              InkWell(
                onTap: () {
                  context.read<TasksCubit>().addTask(
                        widget.tasks[index].copyWith(
                          steps: [
                            StepModel(
                                description: 'step $index description',
                                isCompleted: false),
                            ...widget.tasks[index].steps
                          ],
                        ),
                      );
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text('Add a step'),
                  ],
                ),
              )
          ],
        ),
        children: [
          Text(widget.tasks[index].description),
          if (widget.tasks[index].steps.isNotEmpty)
            TaskWidget(steps: widget.tasks[index].steps),
        ],
      ),
      itemCount: widget.tasks.length,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final List<StepModel> steps;
  const TaskWidget({
    Key? key,
    required this.steps,
  }) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  int _currentStep = 0;
  late List<bool> active = List.filled(widget.steps.length, false);
  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const NeverScrollableScrollPhysics(),
      controlsBuilder: (context, details) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_currentStep < widget.steps.length - 1)
            MaterialButton(
              onPressed: details.onStepContinue,
              color: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.done),
            ),
          const SizedBox(width: 10),
          if (_currentStep > 0)
            MaterialButton(
              onPressed: details.onStepCancel,
              color: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.backspace_outlined),
            )
        ],
      ),
      currentStep: _currentStep,
      onStepTapped: (index) {},
      onStepCancel: () {
        setState(() {
          active[_currentStep] = false;
          _currentStep--;
        });
      },
      onStepContinue: () {
        setState(() {
          active[_currentStep] = true;
          _currentStep++;
        });
      },
      steps: List.generate(
        widget.steps.length,
        (index) => Step(
          title: Text(widget.steps[index].description),
          content: const Text('Description'),
          subtitle: const Text('Subtitle'),
          state: active[index] ? StepState.complete : StepState.indexed,
          isActive: active[index],
        ),
      ),
    );
  }
}
