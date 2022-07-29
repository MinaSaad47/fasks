import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tasks_api/common/utils.dart';
import 'package:uuid/uuid.dart';

part 'step.g.dart';

@JsonSerializable()
class StepModel extends Equatable {
  final String id;
  final String description;
  @JsonKey(
    name: 'is_completed',
    fromJson: Utils.boolFromInt,
    toJson: Utils.boolToInt,
  )
  final bool isCompleted;

  StepModel({
    String? id,
    required this.description,
    required this.isCompleted,
  })  : assert(id == null || id.isNotEmpty),
        id = id ?? Uuid().v4();

  StepModel copyWith({
    String? id,
    String? description,
    bool? isCompleted,
  }) =>
      StepModel(
        id: id ?? this.id,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory StepModel.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toMap() => _$StepToJson(this);

  @override
  List<Object?> get props => [id, description, isCompleted];
}
