import 'package:flutter/material.dart';

/// A chip displaying a participant with remove option.
class ParticipantChip extends StatelessWidget {
  const ParticipantChip({
    super.key,
    required this.name,
    required this.onRemove,
  });

  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      onDeleted: onRemove,
      deleteIcon: const Icon(Icons.close, size: 18),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      deleteIconColor: Theme.of(context).colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
