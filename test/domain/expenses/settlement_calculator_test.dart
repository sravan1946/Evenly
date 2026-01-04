import 'package:flutter_test/flutter_test.dart';
import 'package:evenly/domain/expenses/expense.dart';
import 'package:evenly/domain/expenses/settlement.dart';

void main() {
  test('calculates balances correctly for simple split', () {
    final expenses = [
      Expense(
        id: '1',
        paidBy: 'A',
        amount: 300,
        split: {
          'A': 100,
          'B': 100,
          'C': 100,
        },
      ),
    ];

    final balances =
        SettlementCalculator.calculateBalances(expenses);

    expect(balances['A'], 200);
    expect(balances['B'], -100);
    expect(balances['C'], -100);
  });

  test('generates minimal settlement transactions', () {
    final balances = {
  'A': 200.0,
  'B': -100.0,
  'C': -100.0,
   };


    final settlements =
        SettlementCalculator.generateSettlements(balances);

    expect(settlements.length, 2);

    expect(settlements[0].toUser, 'A');
    expect(settlements[0].amount, 100);

    expect(settlements[1].toUser, 'A');
    expect(settlements[1].amount, 100);
  });
}
