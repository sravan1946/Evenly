import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/providers/saved_people_providers.dart';
import '../widgets/frosted_card.dart';

/// Screen for managing saved people.
class ManagePeopleScreen extends ConsumerStatefulWidget {
  const ManagePeopleScreen({super.key});

  @override
  ConsumerState<ManagePeopleScreen> createState() => _ManagePeopleScreenState();
}

class _ManagePeopleScreenState extends ConsumerState<ManagePeopleScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addPerson() {
    final name = _nameController.text;
    if (name.trim().isNotEmpty) {
      ref.read(savedPeopleProvider.notifier).addPersonByName(name);
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedPeople = ref.watch(savedPeopleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage People'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Person Section
            Text(
              'Add Person',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter name',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                    onSubmitted: (_) => _addPerson(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addPerson,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Saved People List
            Text(
              'Saved People (${savedPeople.length})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (savedPeople.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'No saved people yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              )
            else
              ...savedPeople.map((person) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FrostedCard(
                    child: ListTile(
                      title: Text(person.name),
                      subtitle: Text(
                        'Used ${person.useCount} time${person.useCount != 1 ? 's' : ''}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          ref
                              .read(savedPeopleProvider.notifier)
                              .deletePerson(person.id);
                        },
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
