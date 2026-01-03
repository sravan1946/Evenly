import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/providers/split_providers.dart';
import '../../widgets/frosted_card.dart';

/// Step 1: Create split (optional name).
class CreateSplitStep extends ConsumerStatefulWidget {
  const CreateSplitStep({
    super.key,
    required this.onNext,
  });

  final VoidCallback onNext;

  @override
  ConsumerState<CreateSplitStep> createState() => _CreateSplitStepState();
}

class _CreateSplitStepState extends ConsumerState<CreateSplitStep> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Delay provider modification until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentSplitProvider.notifier).startNewSplit();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleNext() {
    ref.read(currentSplitProvider.notifier).updateName(_nameController.text);
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Create Split',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Give your split a name (optional)',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 40),
          
          // Input Card
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(24),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Split name',
                hintText: 'e.g., Dinner at Restaurant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              textCapitalization: TextCapitalization.words,
              style: Theme.of(context).textTheme.bodyLarge,
              onSubmitted: (_) => _handleNext(),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleNext,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}
