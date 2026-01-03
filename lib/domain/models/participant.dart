import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant.freezed.dart';
part 'participant.g.dart';

/// Represents a participant in a split.
@freezed
class Participant with _$Participant {
  const factory Participant({
    required String id,
    required String name,
  }) = _Participant;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
}
