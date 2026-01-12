import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/saved_person.dart';
import '../../data/local/hive_service.dart';
import '../../core/utils/avatar_colors.dart';

/// Provider for saved people/friends.
final savedPeopleProvider =
    StateNotifierProvider<SavedPeopleNotifier, List<SavedPerson>>((ref) {
      final notifier = SavedPeopleNotifier();
      notifier.loadPeople();
      return notifier;
    });

/// State notifier for managing saved friends.
class SavedPeopleNotifier extends StateNotifier<List<SavedPerson>> {
  SavedPeopleNotifier() : super([]);

  /// Loads saved people from storage.
  void loadPeople() {
    final jsonList = HiveService.loadPeople();
    state = jsonList.map((json) => SavedPerson.fromJson(json)).toList()
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
    state = people..sort((a, b) => b.useCount.compareTo(a.useCount));
    await _saveToStorage();
  }

  /// Adds a person by name (creates new or increments use count).
  /// Automatically assigns an avatar color based on the name.
  Future<void> addPersonByName(String name, {int? customColor}) async {
    if (name.trim().isEmpty) return;

    final trimmedName = name.trim();
    final existing = state.firstWhere(
      (p) => p.name.toLowerCase() == trimmedName.toLowerCase(),
      orElse: () => SavedPerson(id: '', name: '', createdAt: DateTime.now()),
    );

    if (existing.id.isEmpty) {
      // New person - assign avatar color
      final avatarColor =
          customColor ?? AvatarColors.getColorForName(trimmedName);
      final person = SavedPerson(
        id: const Uuid().v4(),
        name: trimmedName,
        createdAt: DateTime.now(),
        useCount: 1,
        avatarColor: avatarColor,
      );
      await savePerson(person);
    } else {
      // Increment use count
      await savePerson(existing.copyWith(useCount: existing.useCount + 1));
    }
  }

  /// Updates an existing person's details.
  Future<void> updatePerson({
    required String id,
    String? name,
    int? avatarColor,
  }) async {
    final index = state.indexWhere((p) => p.id == id);
    if (index < 0) return;

    final person = state[index];
    final updatedPerson = person.copyWith(
      name: name ?? person.name,
      avatarColor: avatarColor ?? person.avatarColor,
    );
    await savePerson(updatedPerson);
  }

  /// Deletes a saved person.
  Future<void> deletePerson(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _saveToStorage();
  }

  /// Gets a person by ID.
  SavedPerson? getPersonById(String id) {
    try {
      return state.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Searches people by name.
  List<SavedPerson> searchByName(String query) {
    if (query.isEmpty) return state;
    final lowerQuery = query.toLowerCase();
    return state
        .where((p) => p.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  Future<void> _saveToStorage() async {
    final jsonList = state.map((p) => p.toJson()).toList();
    await HiveService.savePeople(jsonList);
  }
}
