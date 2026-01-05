import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/split.dart';
import '../../domain/models/participant.dart';
import '../../domain/models/item.dart';
import '../../domain/services/split_calculator.dart';
import '../../data/local/hive_service.dart';

/// Provider for all splits (history).
final splitsProvider = StateNotifierProvider<SplitsNotifier, List<Split>>((
  ref,
) {
  final notifier = SplitsNotifier();
  notifier.loadSplits();
  return notifier;
});

/// Provider for the current split being created/edited.
final currentSplitProvider =
    StateNotifierProvider<CurrentSplitNotifier, Split?>((ref) {
      return CurrentSplitNotifier();
    });

/// Computed provider for recent splits (last 5, sorted by date).
final recentSplitsProvider = Provider<List<Split>>((ref) {
  final splits = ref.watch(splitsProvider);
  final sorted = List<Split>.from(splits)
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return sorted.take(5).toList();
});

/// Computed provider for itemized split calculation.
final itemizedCalculationProvider = Provider<Map<String, double>>((ref) {
  final split = ref.watch(currentSplitProvider);
  if (split == null) return {};
  return SplitCalculator.calculateItemizedSplit(split);
});

/// Computed provider for even split calculation.
final evenCalculationProvider = Provider<Map<String, double>>((ref) {
  final split = ref.watch(currentSplitProvider);
  if (split == null) return {};
  return SplitCalculator.calculateEvenSplit(split);
});

/// Computed provider for total amount.
final totalAmountProvider = Provider<double>((ref) {
  final split = ref.watch(currentSplitProvider);
  if (split == null) return 0.0;
  return SplitCalculator.getTotalAmount(split);
});

/// State notifier for managing all splits.
class SplitsNotifier extends StateNotifier<List<Split>> {
  SplitsNotifier() : super([]);

  /// Loads all splits from storage.
  void loadSplits() {
    state = HiveService.loadSplits();
  }

  /// Adds or updates a split.
  Future<void> saveSplit(Split split) async {
    await HiveService.saveSplit(split);
    loadSplits();
  }

  /// Deletes a split.
  Future<void> deleteSplit(String id) async {
    await HiveService.deleteSplit(id);
    loadSplits();
  }
}

/// State notifier for managing current split being created/edited.
class CurrentSplitNotifier extends StateNotifier<Split?> {
  CurrentSplitNotifier() : super(null);

  /// Starts a new split.
  void startNewSplit({String? name}) {
    state = Split(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      createdAt: DateTime.now(),
    );
  }

  /// Loads a split for editing/viewing.
  void loadSplit(Split split) {
    state = split;
  }

  /// Clears the current split.
  void clear() {
    state = null;
  }

  /// Saves the current split and adds it to history.
  Future<void> saveCurrentSplit(Ref ref) async {
    if (state == null) return;
    await ref.read(splitsProvider.notifier).saveSplit(state!);
    clear();
  }

  /// Adds a participant.
  void addParticipant(String name) {
    if (state == null || name.trim().isEmpty) return;

    final participant = Participant(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
    );

    state = state!.copyWith(
      participants: [...state!.participants, participant],
    );
  }

  /// Removes a participant.
  void removeParticipant(String id) {
    if (state == null) return;

    state = state!.copyWith(
      participants: state!.participants.where((p) => p.id != id).toList(),
      items: state!.items.map((item) {
        return item.copyWith(
          assignedTo: item.assignedTo.where((pid) => pid != id).toList(),
        );
      }).toList(),
    );
  }

  /// Adds an item.
  void addItem(
    String name,
    double price, {
    int quantity = 1,
    String currency = "\$",
  }) {
    if (state == null || name.trim().isEmpty || price <= 0 || quantity <= 0) {
      return;
    }

    final item = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      price: price,
      quantity: quantity,
      currency: currency,
    );

    state = state!.copyWith(items: [...state!.items, item]);
  }

  /// Removes an item.
  void removeItem(String id) {
    if (state == null) return;

    state = state!.copyWith(
      items: state!.items.where((item) => item.id != id).toList(),
    );
  }

  /// Updates item assignment to participants.
  void updateItemAssignment(String itemId, List<String> participantIds) {
    if (state == null) return;

    state = state!.copyWith(
      items: state!.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(assignedTo: participantIds);
        }
        return item;
      }).toList(),
    );
  }

  /// Toggles split method.
  void toggleSplitMethod() {
    if (state == null) return;

    state = state!.copyWith(
      method: state!.method == SplitMethod.itemized
          ? SplitMethod.even
          : SplitMethod.itemized,
    );
  }

  /// Updates split name.
  void updateName(String? name) {
    if (state == null) return;
    state = state!.copyWith(name: name?.trim().isEmpty == true ? null : name);
  }
}
