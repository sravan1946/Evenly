import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/providers/split_providers.dart';
import '../../domain/services/split_calculator.dart';
import '../../domain/models/split.dart';
import '../widgets/frosted_card.dart';
import '../widgets/split_summary_card.dart';

/// Screen showing details of a saved split.
class SplitDetailScreen extends ConsumerWidget {
  const SplitDetailScreen({super.key, required this.splitId});

  final String splitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splits = ref.watch(splitsProvider);
    final split = splits.firstWhere(
      (s) => s.id == splitId,
      orElse: () => splits.first,
    );

    final itemizedAmounts = SplitCalculator.calculateItemizedSplit(split);
    final currency = split.items.first.currency;
    final evenAmounts = SplitCalculator.calculateEvenSplit(split);
    final total = SplitCalculator.getTotalAmount(split);

    final amounts = split.method == SplitMethod.itemized
        ? itemizedAmounts
        : evenAmounts;

    return Scaffold(
      appBar: AppBar(title: Text(split.name ?? 'Split Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Amount
            FrostedCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$currency$total",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Amounts Owed
            Text('Amounts Owed', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ...split.participants.map((participant) {
              final amount = amounts[participant.id] ?? 0.0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SplitSummaryCard(
                  participant: participant,
                  amount: amount,
                  currency: currency,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
