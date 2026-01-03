import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../state/providers/split_providers.dart';
import '../../../domain/models/split.dart';
import '../../widgets/frosted_card.dart';
import '../../widgets/split_summary_card.dart';

/// Step 5: Review and save.
class ReviewStep extends ConsumerWidget {
  const ReviewStep({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  Future<void> _handleSave(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(currentSplitProvider.notifier);
    final splitsNotifier = ref.read(splitsProvider.notifier);
    final split = ref.read(currentSplitProvider);
    if (split != null) {
      await splitsNotifier.saveSplit(split);
      notifier.clear();
    }
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final split = ref.watch(currentSplitProvider);
    final itemizedAmounts = ref.watch(itemizedCalculationProvider);
    final evenAmounts = ref.watch(evenCalculationProvider);
    final total = ref.watch(totalAmountProvider);

    if (split == null) {
      return const Center(child: Text('No split found'));
    }

    final amounts = split.method == SplitMethod.itemized
        ? itemizedAmounts
        : evenAmounts;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Review',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check everything looks good',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 40),
          
          // Total Amount Card
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  'Total Amount',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  _formatPrice(total),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -1,
                      ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Split Method Toggle
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Split Method',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SegmentedButton<SplitMethod>(
                  segments: const [
                    ButtonSegment(
                      value: SplitMethod.itemized,
                      label: Text('Itemized'),
                    ),
                    ButtonSegment(
                      value: SplitMethod.even,
                      label: Text('Even'),
                    ),
                  ],
                  selected: {split.method},
                  onSelectionChanged: (Set<SplitMethod> newSelection) {
                    if (newSelection.first != split.method) {
                      ref.read(currentSplitProvider.notifier).toggleSplitMethod();
                    }
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Participants List
          Text(
            'Amounts Owed',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          
          ...split.participants.map((participant) {
            final amount = amounts[participant.id] ?? 0.0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SplitSummaryCard(
                participant: participant,
                amount: amount,
              ),
            );
          }),
          
          const SizedBox(height: 48),
          
          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _handleSave(context, ref),
                  icon: const Icon(Icons.check, size: 20),
                  label: const Text('Save Split'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
