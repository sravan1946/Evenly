// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedPersonImpl _$$SavedPersonImplFromJson(Map<String, dynamic> json) =>
    _$SavedPersonImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      useCount: (json['useCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SavedPersonImplToJson(_$SavedPersonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'useCount': instance.useCount,
    };
