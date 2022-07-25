import 'package:flutter/material.dart';

class InputTimeFieldPicker extends StatelessWidget {
  final void Function(TimeOfDay)? onPicked;
  final TimeController? controller;
  const InputTimeFieldPicker({Key? key, this.onPicked, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return TextFormField(
      controller: textController,
      validator: (input) {
        return input != null && input.isNotEmpty
            ? null
            : 'Time must be provided';
      },
      onTap: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          String h = time.hour.toString().padLeft(2, '0');
          String m = time.minute.toString().padLeft(2, '0');
          textController.text = '$h:$m';
          if (controller != null) controller!.time = time;
        }
      },
      readOnly: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.watch_later_outlined),
        labelText: 'Pick a time',
      ),
    );
  }
}

class TimeController extends ChangeNotifier {
  TimeOfDay _time;

  TimeController(this._time);

  TimeOfDay get time => _time;
  set time(newTime) {
    _time = newTime;
    notifyListeners();
  }
}
