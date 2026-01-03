import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/providers/split_providers.dart';
import 'new_split_steps/create_split_step.dart';
import 'new_split_steps/add_people_step.dart';
import 'new_split_steps/add_items_step.dart';
import 'new_split_steps/assign_items_step.dart';
import 'new_split_steps/review_step.dart';

/// Step-based flow for creating a new split.
class NewSplitFlow extends ConsumerStatefulWidget {
  const NewSplitFlow({super.key});

  @override
  ConsumerState<NewSplitFlow> createState() => _NewSplitFlowState();
}

class _NewSplitFlowState extends ConsumerState<NewSplitFlow> {
  int _currentStep = 0;

  final List<Widget Function(void Function() next, void Function() back)>
      _steps = [
    (next, back) => CreateSplitStep(onNext: next),
    (next, back) => AddPeopleStep(onNext: next, onBack: back),
    (next, back) => AddItemsStep(onNext: next, onBack: back),
    (next, back) => AssignItemsStep(onNext: next, onBack: back),
    (next, back) => ReviewStep(onBack: back),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Split (${_currentStep + 1}/${_steps.length})'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            ref.read(currentSplitProvider.notifier).clear();
            context.pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(
                _steps.length,
                (index) => Expanded(
                  child: Container(
                    height: 3,
                    margin: EdgeInsets.only(
                      right: index < _steps.length - 1 ? 4 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: index <= _currentStep
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Step content
          Expanded(
            child: _steps[_currentStep](_nextStep, _previousStep),
          ),
        ],
      ),
    );
  }
}
