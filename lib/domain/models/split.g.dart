// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SplitImpl _$$SplitImplFromJson(Map<String, dynamic> json) => _$SplitImpl(
  id: json['id'] as String,
  name: json['name'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  method:
      $enumDecodeNullable(_$SplitMethodEnumMap, json['method']) ??
      SplitMethod.itemized,
);

Map<String, dynamic> _$$SplitImplToJson(_$SplitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'participants': instance.participants,
      'items': instance.items,
      'method': _$SplitMethodEnumMap[instance.method]!,
    };

const _$SplitMethodEnumMap = {
  SplitMethod.itemized: 'itemized',
  SplitMethod.even: 'even',
};
