import 'expense.dart';
import 'settlement_result.dart';

class SettlementCalculator {
  /// Calculates net balance per user
  /// Positive -> user gets money
  /// Negative -> user owes money
  static Map<String, double> calculateBalances(
    List<Expense> expenses,
  ) {
    final Map<String, double> balances = {};

    for (final expense in expenses) {
      // Ensure payer exists
      balances.putIfAbsent(expense.paidBy, () => 0);

      // Payer paid full amount
      balances[expense.paidBy] =
          balances[expense.paidBy]! + expense.amount;

      // Subtract each user's share
      expense.split.forEach((userId, share) {
        balances.putIfAbsent(userId, () => 0);
        balances[userId] = balances[userId]! - share;
      });
    }

    return balances;
  }

  /// Generates minimal settlement transactions
  static List<Settlement> generateSettlements(
    Map<String, double> balances,
  ) {
    final List<Settlement> settlements = [];

    final debtors = balances.entries
        .where((e) => e.value < 0)
        .map((e) => MapEntry(e.key, e.value))
        .toList();

    final creditors = balances.entries
        .where((e) => e.value > 0)
        .map((e) => MapEntry(e.key, e.value))
        .toList();

    int i = 0;
    int j = 0;

    while (i < debtors.length && j < creditors.length) {
      final debtor = debtors[i];
      final creditor = creditors[j];

      final double owe = -debtor.value;
      final double get = creditor.value;
      final double amount = owe < get ? owe : get;

      settlements.add(
        Settlement(
          fromUser: debtor.key,
          toUser: creditor.key,
          amount: amount,
        ),
      );

      debtors[i] =
          MapEntry(debtor.key, debtor.value + amount);
      creditors[j] =
          MapEntry(creditor.key, creditor.value - amount);

      if (debtors[i].value == 0) i++;
      if (creditors[j].value == 0) j++;
    }

    return settlements;
  }
}
