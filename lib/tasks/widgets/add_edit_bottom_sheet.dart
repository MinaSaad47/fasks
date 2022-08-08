import 'package:datetime_form_picker/widgets/widgets.dart';
import 'package:fasks/tasks/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_repository/tasks_repository.dart';

class AddEditTaskSheet extends StatelessWidget {
  final TaskModel? task;

  const AddEditTaskSheet(
    this.task, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addEditFormKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    var timeController = TimeController();
    var dateController = DateController();
    final task = this.task;
    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description;
      timeController.time = TimeOfDay(
        hour: task.finishDate.hour,
        minute: task.finishDate.minute,
      );
      dateController.date = task.finishDate;
    }

    return BlocListener<TaskViewCubit, TaskViewState>(
      listener: (context, state) {
        if (state is TaskViewAddEditTaskSubmitting) {
          var formState = addEditFormKey.currentState;
          if (formState != null && formState.validate()) {
            var t = TaskModel(
              id: task?.id,
              title: titleController.text,
              description: descriptionController.text,
              isCompleted: task?.isCompleted ?? false,
              createdDate: task?.createdDate ?? DateTime.now(),
              finishDate: dateController.date!.add(Duration(
                hours: timeController.time!.hour,
                minutes: timeController.time!.minute,
              )),
            );
            context.read<TaskViewCubit>().saveTask(context, t);
          }
        } else if (state is TaskViewAddEditSuccess) {
          context.read<TasksCubit>().saveTask(state.taskModel);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: addEditFormKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  validator: (text) => text == null || text.isEmpty
                      ? 'please provide a title'
                      : null,
                  decoration: const InputDecoration(labelText: 'Task Title'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  validator: (text) => text == null || text.isEmpty
                      ? 'please provide a description'
                      : null,
                  decoration:
                      const InputDecoration(labelText: 'Task Description'),
                  minLines: 3,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DateFormPicker(
                        controller: dateController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TimeFormPicker(
                        controller: timeController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddEditStepSheet extends StatelessWidget {
  final TaskModel task;
  final StepModel? step;

  const AddEditStepSheet(this.task, {Key? key, this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addEditKey = GlobalKey<FormState>();
    var descriptionController = TextEditingController();
    final step = this.step;
    if (step != null) {
      descriptionController.text = step.description;
    }
    return BlocListener<TaskViewCubit, TaskViewState>(
      listener: (context, state) {
        if (state is TaskViewAddEditStepSubmitting) {
          var formState = addEditKey.currentState;
          if (formState != null && formState.validate()) {
            StepModel s = StepModel(
              id: step?.id,
              description: descriptionController.text,
              isCompleted: step?.isCompleted ?? false,
            );
            int index = task.steps.indexWhere((step) => step.id == s.id);
            if (index >= 0) {
              task.steps[index] = s;
            } else {
              task.steps.add(s);
            }
            context.read<TaskViewCubit>().saveTask(context, task);
          }
        } else if (state is TaskViewAddEditSuccess) {
          context.read<TasksCubit>().saveTask(state.taskModel);
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: addEditKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  validator: (text) => text == null || text.isEmpty
                      ? 'please provide a description'
                      : null,
                  decoration:
                      const InputDecoration(labelText: 'Step Description'),
                  minLines: 3,
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
