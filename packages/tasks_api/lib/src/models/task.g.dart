// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: Utils.boolFromInt(json['is_completed'] as int),
      createdDate: DateTime.parse(json['created_date'] as String),
      finishDate: DateTime.parse(json['finish_date'] as String),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => StepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_completed': Utils.boolToInt(instance.isCompleted),
      'created_date': instance.createdDate.toIso8601String(),
      'finish_date': instance.finishDate.toIso8601String(),
      'steps': instance.steps,
    };
