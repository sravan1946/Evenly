import 'package:evenly/state/providers/preferences_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/models/participant.dart';
import 'frosted_card.dart';

/// A card showing participant → amount mapping.
class SplitSummaryCard extends ConsumerWidget {
  const SplitSummaryCard({
    super.key,
    required this.participant,
    required this.amount,
    this.currency = '\$',
  });

  final Participant participant;
  final String currency;
  final double amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    return FrostedCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
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
                "$currency$amount",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Visibility(
            visible: currency == "₹" && preferences.upiId != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pay to me with UPI"),
                    Text(
                      preferences.upiId ?? "UPI ID NOT SET",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                QrImageView(
                  data: 'upi://pay?pa=${preferences.upiId}&am=$amount&cu=INR',
                  version: QrVersions.auto,
                  dataModuleStyle: QrDataModuleStyle(
                    color: Theme.of(context).textTheme.displayMedium?.color,
                  ),
                  eyeStyle: QrEyeStyle(
                    color: Theme.of(context).textTheme.displayMedium?.color,
                  ),
                  size: 100.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
