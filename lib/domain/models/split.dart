import 'package:freezed_annotation/freezed_annotation.dart';
import 'participant.dart';
import 'item.dart';

part 'split.freezed.dart';
part 'split.g.dart';

/// Split method enum.
enum SplitMethod {
  @JsonValue('itemized')
  itemized,
  @JsonValue('even')
  even,
}

/// Represents a complete split with participants, items, and method.
@freezed
class Split with _$Split {
  const factory Split({
    required String id,
    String? name,
    required DateTime createdAt,
    @Default([]) List<Participant> participants,
    @Default([]) List<Item> items,
    @Default(SplitMethod.itemized) SplitMethod method,
  }) = _Split;

  factory Split.fromJson(Map<String, dynamic> json) => _$SplitFromJson(json);
}
