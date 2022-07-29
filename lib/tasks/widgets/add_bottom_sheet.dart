import 'package:datetime_form_picker/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeController = TimeController(TimeOfDay.now());
    var dateController = DateController(DateTime.now());
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
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
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
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
    );
  }
}
