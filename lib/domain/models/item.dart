import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// Represents an item in a receipt.
@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required double price,
    @Default("\$") String currency,
    @Default(1) int quantity,
    @Default([]) List<String> assignedTo,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
