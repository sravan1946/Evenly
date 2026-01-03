import '../models/split.dart';

/// Service for calculating split amounts.
class SplitCalculator {
  SplitCalculator._();

  /// Calculates itemized split - each participant pays for their assigned items.
  static Map<String, double> calculateItemizedSplit(Split split) {
    final Map<String, double> amounts = {};

    // Initialize all participants with 0
    for (final participant in split.participants) {
      amounts[participant.id] = 0.0;
    }

    // Sum up prices for items assigned to each participant
    for (final item in split.items) {
      if (item.assignedTo.isEmpty) {
        continue; // Skip unassigned items
      }

      final totalItemPrice = item.price * item.quantity;
      final pricePerPerson = totalItemPrice / item.assignedTo.length;

      for (final participantId in item.assignedTo) {
        amounts[participantId] = (amounts[participantId] ?? 0.0) + pricePerPerson;
      }
    }

    return amounts;
  }

  /// Calculates even split - total divided equally among all participants.
  static Map<String, double> calculateEvenSplit(Split split) {
    final Map<String, double> amounts = {};

    if (split.participants.isEmpty) {
      return amounts;
    }

    final total = getTotalAmount(split);
    final amountPerPerson = total / split.participants.length;

    for (final participant in split.participants) {
      amounts[participant.id] = amountPerPerson;
    }

    return amounts;
  }

  /// Gets the total amount of all items.
  static double getTotalAmount(Split split) {
    return split.items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
