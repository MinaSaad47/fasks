import 'package:flutter/material.dart';

class InputDateFieldPicker extends StatelessWidget {
  final void Function(DateTime)? onPicked;
  final DateController? controller;
  const InputDateFieldPicker({Key? key, this.onPicked, this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return TextFormField(
      controller: textController,
      validator: (input) {
        return input != null && input.isNotEmpty
            ? null
            : 'Date must be provided';
      },
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(4747),
        );
        if (date != null) {
          String d = date.day.toString().padLeft(2, '0');
          String m = date.month.toString().padLeft(2, '0');
          String y = date.year.toString();
          textController.text = '$d/$m/$y';
          if (controller != null) controller!.date = date;
        }
      },
      readOnly: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.date_range_outlined),
        labelText: 'Pick a date',
      ),
    );
    ;
  }
}

class DateController extends ChangeNotifier {
  DateTime _date;

  DateController(this._date);

  DateTime get date => _date;
  set date(newDate) {
    _date = newDate;
    notifyListeners();
  }
}
