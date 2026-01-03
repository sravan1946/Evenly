// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Split _$SplitFromJson(Map<String, dynamic> json) {
  return _Split.fromJson(json);
}

/// @nodoc
mixin _$Split {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<Participant> get participants => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;
  SplitMethod get method => throw _privateConstructorUsedError;

  /// Serializes this Split to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SplitCopyWith<Split> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplitCopyWith<$Res> {
  factory $SplitCopyWith(Split value, $Res Function(Split) then) =
      _$SplitCopyWithImpl<$Res, Split>;
  @useResult
  $Res call({
    String id,
    String? name,
    DateTime createdAt,
    List<Participant> participants,
    List<Item> items,
    SplitMethod method,
  });
}

/// @nodoc
class _$SplitCopyWithImpl<$Res, $Val extends Split>
    implements $SplitCopyWith<$Res> {
  _$SplitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? createdAt = null,
    Object? participants = null,
    Object? items = null,
    Object? method = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<Participant>,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Item>,
            method: null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                      as SplitMethod,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SplitImplCopyWith<$Res> implements $SplitCopyWith<$Res> {
  factory _$$SplitImplCopyWith(
    _$SplitImpl value,
    $Res Function(_$SplitImpl) then,
  ) = __$$SplitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? name,
    DateTime createdAt,
    List<Participant> participants,
    List<Item> items,
    SplitMethod method,
  });
}

/// @nodoc
class __$$SplitImplCopyWithImpl<$Res>
    extends _$SplitCopyWithImpl<$Res, _$SplitImpl>
    implements _$$SplitImplCopyWith<$Res> {
  __$$SplitImplCopyWithImpl(
    _$SplitImpl _value,
    $Res Function(_$SplitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? createdAt = null,
    Object? participants = null,
    Object? items = null,
    Object? method = null,
  }) {
    return _then(
      _$SplitImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<Participant>,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Item>,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as SplitMethod,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SplitImpl implements _Split {
  const _$SplitImpl({
    required this.id,
    this.name,
    required this.createdAt,
    final List<Participant> participants = const [],
    final List<Item> items = const [],
    this.method = SplitMethod.itemized,
  }) : _participants = participants,
       _items = items;

  factory _$SplitImpl.fromJson(Map<String, dynamic> json) =>
      _$$SplitImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final DateTime createdAt;
  final List<Participant> _participants;
  @override
  @JsonKey()
  List<Participant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<Item> _items;
  @override
  @JsonKey()
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final SplitMethod method;

  @override
  String toString() {
    return 'Split(id: $id, name: $name, createdAt: $createdAt, participants: $participants, items: $items, method: $method)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SplitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.method, method) || other.method == method));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    createdAt,
    const DeepCollectionEquality().hash(_participants),
    const DeepCollectionEquality().hash(_items),
    method,
  );

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SplitImplCopyWith<_$SplitImpl> get copyWith =>
      __$$SplitImplCopyWithImpl<_$SplitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SplitImplToJson(this);
  }
}

abstract class _Split implements Split {
  const factory _Split({
    required final String id,
    final String? name,
    required final DateTime createdAt,
    final List<Participant> participants,
    final List<Item> items,
    final SplitMethod method,
  }) = _$SplitImpl;

  factory _Split.fromJson(Map<String, dynamic> json) = _$SplitImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  DateTime get createdAt;
  @override
  List<Participant> get participants;
  @override
  List<Item> get items;
  @override
  SplitMethod get method;

  /// Create a copy of Split
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SplitImplCopyWith<_$SplitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
