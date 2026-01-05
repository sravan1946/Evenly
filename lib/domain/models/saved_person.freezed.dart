// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedPerson _$SavedPersonFromJson(Map<String, dynamic> json) {
  return _SavedPerson.fromJson(json);
}

/// @nodoc
mixin _$SavedPerson {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get useCount => throw _privateConstructorUsedError;

  /// Avatar color stored as hex value (e.g., 0xFF6366F1)
  int? get avatarColor => throw _privateConstructorUsedError;

  /// Serializes this SavedPerson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedPersonCopyWith<SavedPerson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPersonCopyWith<$Res> {
  factory $SavedPersonCopyWith(
    SavedPerson value,
    $Res Function(SavedPerson) then,
  ) = _$SavedPersonCopyWithImpl<$Res, SavedPerson>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    int useCount,
    int? avatarColor,
  });
}

/// @nodoc
class _$SavedPersonCopyWithImpl<$Res, $Val extends SavedPerson>
    implements $SavedPersonCopyWith<$Res> {
  _$SavedPersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? useCount = null,
    Object? avatarColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            useCount: null == useCount
                ? _value.useCount
                : useCount // ignore: cast_nullable_to_non_nullable
                      as int,
            avatarColor: freezed == avatarColor
                ? _value.avatarColor
                : avatarColor // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedPersonImplCopyWith<$Res>
    implements $SavedPersonCopyWith<$Res> {
  factory _$$SavedPersonImplCopyWith(
    _$SavedPersonImpl value,
    $Res Function(_$SavedPersonImpl) then,
  ) = __$$SavedPersonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime createdAt,
    int useCount,
    int? avatarColor,
  });
}

/// @nodoc
class __$$SavedPersonImplCopyWithImpl<$Res>
    extends _$SavedPersonCopyWithImpl<$Res, _$SavedPersonImpl>
    implements _$$SavedPersonImplCopyWith<$Res> {
  __$$SavedPersonImplCopyWithImpl(
    _$SavedPersonImpl _value,
    $Res Function(_$SavedPersonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedPerson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? useCount = null,
    Object? avatarColor = freezed,
  }) {
    return _then(
      _$SavedPersonImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        useCount: null == useCount
            ? _value.useCount
            : useCount // ignore: cast_nullable_to_non_nullable
                  as int,
        avatarColor: freezed == avatarColor
            ? _value.avatarColor
            : avatarColor // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedPersonImpl implements _SavedPerson {
  const _$SavedPersonImpl({
    required this.id,
    required this.name,
    required this.createdAt,
    this.useCount = 0,
    this.avatarColor,
  });

  factory _$SavedPersonImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedPersonImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int useCount;

  /// Avatar color stored as hex value (e.g., 0xFF6366F1)
  @override
  final int? avatarColor;

  @override
  String toString() {
    return 'SavedPerson(id: $id, name: $name, createdAt: $createdAt, useCount: $useCount, avatarColor: $avatarColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedPersonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.useCount, useCount) ||
                other.useCount == useCount) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, createdAt, useCount, avatarColor);

  /// Create a copy of SavedPerson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedPersonImplCopyWith<_$SavedPersonImpl> get copyWith =>
      __$$SavedPersonImplCopyWithImpl<_$SavedPersonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedPersonImplToJson(this);
  }
}

abstract class _SavedPerson implements SavedPerson {
  const factory _SavedPerson({
    required final String id,
    required final String name,
    required final DateTime createdAt,
    final int useCount,
    final int? avatarColor,
  }) = _$SavedPersonImpl;

  factory _SavedPerson.fromJson(Map<String, dynamic> json) =
      _$SavedPersonImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get createdAt;
  @override
  int get useCount;

  /// Avatar color stored as hex value (e.g., 0xFF6366F1)
  @override
  int? get avatarColor;

  /// Create a copy of SavedPerson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedPersonImplCopyWith<_$SavedPersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
