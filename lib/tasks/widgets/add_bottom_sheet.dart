import 'package:fasks/tasks/tasks.dart';
import 'package:fasks/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeController = TimeController(TimeOfDay.now());
    var dateController = DateController(DateTime.now());
    var formKey = GlobalKey<FormState>();
    return BlocListener<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is TasksAddBottomSheetSubmit) {
          var formState = formKey.currentState;
          if (formState != null && formState.validate()) {
            context.read<TasksCubit>().closeAddBottomSheet();
          }
        }
      },
      child: Form(
        key: formKey,
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
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration:
                    const InputDecoration(labelText: 'Task Description'),
                minLines: 3,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: InputTimeFieldPicker(
                      controller: timeController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InputDateFieldPicker(
                      controller: dateController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
