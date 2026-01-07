// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppPreferencesImpl _$$AppPreferencesImplFromJson(Map<String, dynamic> json) =>
    _$AppPreferencesImpl(
      theme: json['theme'] as String? ?? 'system',
      currency: json['currency'] as String? ?? 'USD',
      rounding: json['rounding'] as String? ?? 'cent',
      upiId: json['upiId'] as String?,
    );

Map<String, dynamic> _$$AppPreferencesImplToJson(
  _$AppPreferencesImpl instance,
) => <String, dynamic>{
  'theme': instance.theme,
  'currency': instance.currency,
  'rounding': instance.rounding,
  'upiId': instance.upiId,
};
