import 'package:flutter/material.dart';
import '../../domain/models/participant.dart';
import 'frosted_card.dart';

/// A card showing participant → amount mapping.
class SplitSummaryCard extends StatelessWidget {
  const SplitSummaryCard({
    super.key,
    required this.participant,
    required this.amount,
  });

  final Participant participant;
  final double amount;

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participant.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Owes',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Text(
            _formatPrice(amount),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -0.5,
                ),
          ),
        ],
      ),
    );
  }
}
