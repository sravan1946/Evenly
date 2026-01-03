// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  assignedTo:
      (json['assignedTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'assignedTo': instance.assignedTo,
    };
