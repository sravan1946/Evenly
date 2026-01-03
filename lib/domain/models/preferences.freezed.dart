// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppPreferences _$AppPreferencesFromJson(Map<String, dynamic> json) {
  return _AppPreferences.fromJson(json);
}

/// @nodoc
mixin _$AppPreferences {
  String get theme => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get rounding => throw _privateConstructorUsedError;

  /// Serializes this AppPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppPreferencesCopyWith<AppPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPreferencesCopyWith<$Res> {
  factory $AppPreferencesCopyWith(
    AppPreferences value,
    $Res Function(AppPreferences) then,
  ) = _$AppPreferencesCopyWithImpl<$Res, AppPreferences>;
  @useResult
  $Res call({String theme, String currency, String rounding});
}

/// @nodoc
class _$AppPreferencesCopyWithImpl<$Res, $Val extends AppPreferences>
    implements $AppPreferencesCopyWith<$Res> {
  _$AppPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? currency = null,
    Object? rounding = null,
  }) {
    return _then(
      _value.copyWith(
            theme: null == theme
                ? _value.theme
                : theme // ignore: cast_nullable_to_non_nullable
                      as String,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            rounding: null == rounding
                ? _value.rounding
                : rounding // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppPreferencesImplCopyWith<$Res>
    implements $AppPreferencesCopyWith<$Res> {
  factory _$$AppPreferencesImplCopyWith(
    _$AppPreferencesImpl value,
    $Res Function(_$AppPreferencesImpl) then,
  ) = __$$AppPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String theme, String currency, String rounding});
}

/// @nodoc
class __$$AppPreferencesImplCopyWithImpl<$Res>
    extends _$AppPreferencesCopyWithImpl<$Res, _$AppPreferencesImpl>
    implements _$$AppPreferencesImplCopyWith<$Res> {
  __$$AppPreferencesImplCopyWithImpl(
    _$AppPreferencesImpl _value,
    $Res Function(_$AppPreferencesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? currency = null,
    Object? rounding = null,
  }) {
    return _then(
      _$AppPreferencesImpl(
        theme: null == theme
            ? _value.theme
            : theme // ignore: cast_nullable_to_non_nullable
                  as String,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        rounding: null == rounding
            ? _value.rounding
            : rounding // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppPreferencesImpl implements _AppPreferences {
  const _$AppPreferencesImpl({
    this.theme = 'system',
    this.currency = 'USD',
    this.rounding = 'cent',
  });

  factory _$AppPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final String theme;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String rounding;

  @override
  String toString() {
    return 'AppPreferences(theme: $theme, currency: $currency, rounding: $rounding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppPreferencesImpl &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.rounding, rounding) ||
                other.rounding == rounding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, theme, currency, rounding);

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppPreferencesImplCopyWith<_$AppPreferencesImpl> get copyWith =>
      __$$AppPreferencesImplCopyWithImpl<_$AppPreferencesImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppPreferencesImplToJson(this);
  }
}

abstract class _AppPreferences implements AppPreferences {
  const factory _AppPreferences({
    final String theme,
    final String currency,
    final String rounding,
  }) = _$AppPreferencesImpl;

  factory _AppPreferences.fromJson(Map<String, dynamic> json) =
      _$AppPreferencesImpl.fromJson;

  @override
  String get theme;
  @override
  String get currency;
  @override
  String get rounding;

  /// Create a copy of AppPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppPreferencesImplCopyWith<_$AppPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
