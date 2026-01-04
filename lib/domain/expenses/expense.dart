class Expense {
  final String id;
  final String paidBy; // userId
  final double amount;
  final Map<String, double> split; // userId -> share

  Expense({
    required this.id,
    required this.paidBy,
    required this.amount,
    required this.split,
  });
}
