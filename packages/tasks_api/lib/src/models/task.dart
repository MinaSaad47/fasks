import 'package:tasks_api/tasks_api.dart';
import 'package:uuid/uuid.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final DateTime createdDate;
  final DateTime finishDate;
  final List<Step> steps;

  Task(
      {String? id,
      required this.title,
      required this.description,
      required this.createdDate,
      required this.finishDate,
      List<Step>? steps})
      : assert(id == null || id.isNotEmpty, 'id should not be empty'),
        id = Uuid().v4(),
        steps = steps ?? [];

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdDate,
    DateTime? finishDate,
    List<Step>? steps,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
        finishDate: finishDate ?? this.finishDate,
        steps: steps ?? this.steps,
      );
}
