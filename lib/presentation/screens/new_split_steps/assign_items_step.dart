import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/providers/split_providers.dart';
import '../../../domain/models/split.dart';
import '../../widgets/frosted_card.dart';

/// Step 4: Assign items to people.
class AssignItemsStep extends ConsumerWidget {
  const AssignItemsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  void _handleNext(BuildContext context, WidgetRef ref) {
    final split = ref.read(currentSplitProvider);
    final unassignedItems =
        split?.items.where((item) => item.assignedTo.isEmpty).toList() ?? [];

    if (unassignedItems.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please assign all ${unassignedItems.length} item(s)'),
        ),
      );
      return;
    }

    onNext();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final split = ref.watch(currentSplitProvider);

    if (split == null) {
      return const Center(child: Text('No split found'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Assign Items',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Who had what?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Split Method Toggle
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Split Method',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SegmentedButton<SplitMethod>(
                  segments: const [
                    ButtonSegment(
                      value: SplitMethod.itemized,
                      label: Text('Itemized'),
                    ),
                    ButtonSegment(value: SplitMethod.even, label: Text('Even')),
                  ],
                  selected: {split.method},
                  onSelectionChanged: (Set<SplitMethod> newSelection) {
                    if (newSelection.first != split.method) {
                      ref
                          .read(currentSplitProvider.notifier)
                          .toggleSplitMethod();
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Items List
          Text(
            'Items (${split.items.length})',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          ...split.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FrostedCard(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          '${item.currency}${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    if (item.quantity > 1) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${item.quantity}x ${item.currency}${item.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: split.participants.map((participant) {
                        final isAssigned = item.assignedTo.contains(
                          participant.id,
                        );
                        return FilterChip(
                          label: Text(participant.name),
                          selected: isAssigned,
                          onSelected: (selected) {
                            final newAssignments = List<String>.from(
                              item.assignedTo,
                            );
                            if (selected) {
                              if (!newAssignments.contains(participant.id)) {
                                newAssignments.add(participant.id);
                              }
                            } else {
                              newAssignments.remove(participant.id);
                            }
                            ref
                                .read(currentSplitProvider.notifier)
                                .updateItemAssignment(item.id, newAssignments);
                          },
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          checkmarkColor: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
                child: ElevatedButton(
                  onPressed: () => _handleNext(context, ref),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Continue'),
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
