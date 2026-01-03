import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/providers/split_providers.dart';
import '../../widgets/frosted_card.dart';
import '../../widgets/item_row.dart';

/// Step 3: Add items.
class AddItemsStep extends ConsumerStatefulWidget {
  const AddItemsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<AddItemsStep> createState() => _AddItemsStepState();
}

class _AddItemsStepState extends ConsumerState<AddItemsStep> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _nameController.text;
    // Remove $ prefix if user typed it, but keep only one
    String priceText = _priceController.text.trim();
    if (priceText.startsWith('\$')) {
      priceText = priceText.substring(1).trim();
    }
    final price = double.tryParse(priceText);
    final quantity = int.tryParse(_quantityController.text) ?? 1;

    if (name.trim().isNotEmpty && price != null && price > 0 && quantity > 0) {
      ref.read(currentSplitProvider.notifier).addItem(name, price, quantity: quantity);
      _nameController.clear();
      _priceController.clear();
      _quantityController.text = '1';
    }
  }

  void _handleNext() {
    final split = ref.read(currentSplitProvider);
    if (split?.items.isNotEmpty == true) {
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final split = ref.watch(currentSplitProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Add Items',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'What did you buy?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 32),
          
          // Input Card
          FrostedCard(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Item Name
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Item name',
                    hintText: 'e.g., Pizza',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  textCapitalization: TextCapitalization.words,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                
                // Quantity and Price Row
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          hintText: '1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: '0.00',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefix: Text(
                            '\$',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        style: Theme.of(context).textTheme.bodyLarge,
                        onSubmitted: (_) => _addItem(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Add Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add_shopping_cart, size: 20),
              label: const Text('Add Item'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Items List
          if (split?.items.isNotEmpty == true) ...[
            Text(
              'Items (${split!.items.length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            ...split.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FrostedCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(20),
                  onTap: () => ref
                      .read(currentSplitProvider.notifier)
                      .removeItem(item.id),
                  child: ItemRow(
                    item: item,
                    participants: split.participants,
                    showAssignments: false,
                    onTap: null,
                  ),
                ),
              );
            }),
          ] else
            FrostedCard(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No items yet',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
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
