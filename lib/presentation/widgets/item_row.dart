import 'package:flutter/material.dart';
import '../../domain/models/item.dart';
import '../../domain/models/participant.dart';

/// A row displaying an item with its price and assigned participants.
class ItemRow extends StatelessWidget {
  const ItemRow({
    super.key,
    required this.item,
    required this.participants,
    this.onTap,
    this.showAssignments = true,
  });

  final Item item;
  final List<Participant> participants;
  final VoidCallback? onTap;
  final bool showAssignments;

  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  String _formatTotalPrice() {
    final total = item.price * item.quantity;
    return '\$${total.toStringAsFixed(2)}';
  }

  List<String> _getParticipantNames() {
    return item.assignedTo
        .map((id) => participants.where((p) => p.id == id).firstOrNull?.name)
        .whereType<String>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final participantNames = showAssignments ? _getParticipantNames() : [];

    return ListTile(
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: participantNames.isNotEmpty
          ? Text(
              participantNames.join(', '),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            )
          : null,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (item.quantity > 1)
            Text(
              '${item.quantity}x ${_formatPrice(item.price)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          Text(
            _formatTotalPrice(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
