import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'step.g.dart';

@JsonSerializable()
class Step extends Equatable {
  final String id;
  final String description;

  Step({
    String? id,
    required this.description,
  })  : assert(id == null || id.isNotEmpty),
        id = id ?? Uuid().v4();

  Step copyWith({String? id, String? description}) =>
      Step(id: id ?? this.id, description: description ?? this.description);

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toMap() => _$StepToJson(this);

  @override
  List<Object?> get props => [id, description];
}
