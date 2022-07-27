import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasks_api/tasks_api.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'created_date')
  final DateTime createdDate;
  @JsonKey(name: 'finish_date')
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
        id = id ?? Uuid().v4(),
        steps = steps ?? [];

  Task copyWith({
    String? title,
    String? description,
    DateTime? createdDate,
    DateTime? finishDate,
    List<Step>? steps,
  }) =>
      Task(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate,
        finishDate: finishDate ?? this.finishDate,
        steps: steps ?? this.steps,
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toMap() => _$TaskToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        createdDate,
        finishDate,
        steps,
      ];
}
