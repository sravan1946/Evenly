import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_person.freezed.dart';
part 'saved_person.g.dart';

/// Represents a saved person for quick reuse.
@freezed
class SavedPerson with _$SavedPerson {
  const factory SavedPerson({
    required String id,
    required String name,
    required DateTime createdAt,
    @Default(0) int useCount,
  }) = _SavedPerson;

  factory SavedPerson.fromJson(Map<String, dynamic> json) =>
      _$SavedPersonFromJson(json);
}
