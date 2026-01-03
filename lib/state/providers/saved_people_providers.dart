import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/saved_person.dart';
import '../../data/local/hive_service.dart';

/// Provider for saved people.
final savedPeopleProvider =
    StateNotifierProvider<SavedPeopleNotifier, List<SavedPerson>>((ref) {
  final notifier = SavedPeopleNotifier();
  notifier.loadPeople();
  return notifier;
});

/// State notifier for managing saved people.
class SavedPeopleNotifier extends StateNotifier<List<SavedPerson>> {
  SavedPeopleNotifier() : super([]);

  /// Loads saved people from storage.
  void loadPeople() {
    final jsonList = HiveService.loadPeople();
    state = jsonList
        .map((json) => SavedPerson.fromJson(json))
        .toList()
      ..sort((a, b) => b.useCount.compareTo(a.useCount));
  }

  /// Adds or updates a saved person.
  Future<void> savePerson(SavedPerson person) async {
    final people = List<SavedPerson>.from(state);
    final index = people.indexWhere((p) => p.id == person.id);
    if (index >= 0) {
      people[index] = person;
    } else {
      people.add(person);
    }
    state = people;
    await _saveToStorage();
  }

  /// Adds a person by name (creates new or increments use count).
  Future<void> addPersonByName(String name) async {
    if (name.trim().isEmpty) return;

    final trimmedName = name.trim();
    final existing = state.firstWhere(
      (p) => p.name.toLowerCase() == trimmedName.toLowerCase(),
      orElse: () => SavedPerson(
        id: '',
        name: '',
        createdAt: DateTime.now(),
      ),
    );

    if (existing.id.isEmpty) {
      // New person
      final person = SavedPerson(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: trimmedName,
        createdAt: DateTime.now(),
        useCount: 1,
      );
      await savePerson(person);
    } else {
      // Increment use count
      await savePerson(existing.copyWith(useCount: existing.useCount + 1));
    }
  }

  /// Deletes a saved person.
  Future<void> deletePerson(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    final jsonList = state.map((p) => p.toJson()).toList();
    await HiveService.savePeople(jsonList);
  }
}
