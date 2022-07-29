// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepModel _$StepFromJson(Map<String, dynamic> json) => StepModel(
      id: json['id'] as String?,
      description: json['description'] as String,
      isCompleted: Utils.boolFromInt(json['is_completed'] as int),
    );

Map<String, dynamic> _$StepToJson(StepModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'is_completed': Utils.boolToInt(instance.isCompleted),
    };
