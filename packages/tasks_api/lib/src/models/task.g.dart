// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['created_date'] as String),
      finishDate: DateTime.parse(json['finish_date'] as String),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_date': instance.createdDate.toIso8601String(),
      'finish_date': instance.finishDate.toIso8601String(),
      'steps': instance.steps,
    };
