import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasks_api/common/utils.dart';
import 'package:tasks_api/tasks_api.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskModel extends Equatable {
  final String id;
  final String title;
  final String description;
  @JsonKey(
    name: 'is_completed',
    fromJson: Utils.boolFromInt,
    toJson: Utils.boolToInt,
  )
  final bool isCompleted;
  @JsonKey(name: 'created_date')
  final DateTime createdDate;
  @JsonKey(name: 'finish_date')
  final DateTime finishDate;
  final List<StepModel> steps;

  TaskModel(
      {String? id,
      required this.title,
      required this.description,
      required this.isCompleted,
      required this.createdDate,
      required this.finishDate,
      List<StepModel>? steps})
      : assert(id == null || id.isNotEmpty, 'id should not be empty'),
        id = id ?? Uuid().v4(),
        steps = steps ?? [];

  TaskModel copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdDate,
    DateTime? finishDate,
    List<StepModel>? steps,
  }) =>
      TaskModel(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        createdDate: createdDate ?? this.createdDate,
        finishDate: finishDate ?? this.finishDate,
        steps: steps ?? this.steps,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
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
