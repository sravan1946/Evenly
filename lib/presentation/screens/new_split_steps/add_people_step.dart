import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/providers/split_providers.dart';
import '../../../state/providers/saved_people_providers.dart';
import '../../widgets/participant_chip.dart';
import '../../widgets/frosted_card.dart';

/// Step 2: Add people.
class AddPeopleStep extends ConsumerStatefulWidget {
  const AddPeopleStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<AddPeopleStep> createState() => _AddPeopleStepState();
}

class _AddPeopleStepState extends ConsumerState<AddPeopleStep> {
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addParticipant(String name) {
    if (name.trim().isNotEmpty) {
      ref.read(currentSplitProvider.notifier).addParticipant(name.trim());
      // Save to saved people
      ref.read(savedPeopleProvider.notifier).addPersonByName(name.trim());
      _nameController.clear();
      _focusNode.requestFocus();
    }
  }

  void _handleNext() {
    final split = ref.read(currentSplitProvider);
    if (split?.participants.isNotEmpty == true) {
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one person')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final split = ref.watch(currentSplitProvider);
    final savedPeople = ref.watch(savedPeopleProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Add People',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Who\'s splitting this bill?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 32),
          
          // Saved People Section
          if (savedPeople.isNotEmpty) ...[
            Text(
              'Quick Add',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            FrostedCard(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: savedPeople.take(8).map((person) {
                  final isAdded = split?.participants.any(
                        (p) => p.name.toLowerCase() == person.name.toLowerCase(),
                      ) ??
                      false;
                  return ActionChip(
                    label: Text(person.name),
                    avatar: Icon(
                      isAdded ? Icons.check_circle : Icons.person_add,
                      size: 18,
                    ),
                    onPressed: isAdded
                        ? null
                        : () => _addParticipant(person.name),
                    backgroundColor: isAdded
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : Theme.of(context).colorScheme.primaryContainer,
                    labelStyle: TextStyle(
                      color: isAdded
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Add New Person Section
          Text(
            'Add New Person',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                    textCapitalization: TextCapitalization.words,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onSubmitted: (value) => _addParticipant(value),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _addParticipant(_nameController.text),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Participants List
          if (split?.participants.isNotEmpty == true) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Participants (${split!.participants.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (split.participants.length > 1)
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Clear All?'),
                          content: const Text(
                            'Remove all participants?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                for (final participant in split.participants) {
                                  ref
                                      .read(currentSplitProvider.notifier)
                                      .removeParticipant(participant.id);
                                }
                                Navigator.pop(context);
                              },
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.clear_all, size: 18),
                    label: const Text('Clear All'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: split.participants.map((participant) {
                return ParticipantChip(
                  name: participant.name,
                  onRemove: () => ref
                      .read(currentSplitProvider.notifier)
                      .removeParticipant(participant.id),
                );
              }).toList(),
            ),
          ] else
            FrostedCard(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No participants yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    if (savedPeople.isEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Tap "Quick Add" or enter a name above',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: 48),
          
          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onBack,
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
                  onPressed: _handleNext,
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
