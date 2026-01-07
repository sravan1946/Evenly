import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences.freezed.dart';
part 'preferences.g.dart';

/// App preferences.
@freezed
class AppPreferences with _$AppPreferences {
  const factory AppPreferences({
    @Default('system') String theme,
    @Default('USD') String currency,
    @Default('cent') String rounding,
    String? upiId,
  }) = _AppPreferences;

  factory AppPreferences.fromJson(Map<String, dynamic> json) =>
      _$AppPreferencesFromJson(json);
}
