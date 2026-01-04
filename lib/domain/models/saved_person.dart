import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_person.freezed.dart';
part 'saved_person.g.dart';

/// Represents a saved friend/person for quick reuse in bill splitting.
/// Includes avatar color for visual identification.
@freezed
class SavedPerson with _$SavedPerson {
  const factory SavedPerson({
    required String id,
    required String name,
    required DateTime createdAt,
    @Default(0) int useCount,
    /// Avatar color stored as hex value (e.g., 0xFF6366F1)
    int? avatarColor,
  }) = _SavedPerson;

  factory SavedPerson.fromJson(Map<String, dynamic> json) =>
      _$SavedPersonFromJson(json);
}
