import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/split.dart';
import 'adapters.dart';

/// Service for Hive local storage operations.
class HiveService {
  HiveService._();

  static Box? _box;

  /// Initializes Hive, registers adapters, and opens the splits box.
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(ParticipantAdapter());
    Hive.registerAdapter(SplitMethodAdapter());
    Hive.registerAdapter(SplitAdapter());
    
    _box = await Hive.openBox(AppConstants.splitsBoxName);
    
    // Migration: Check for old JSON list and convert to individual objects
    if (_box!.containsKey(_splitsListKey)) {
      await _migrateOldData();
    }
  }

  static const String _splitsListKey = 'splits_list';
  static const String _savedPeopleKey = 'saved_people';
  static const String _preferencesKey = 'preferences';

    /// Internal migration from JSON list to individual objects
  static Future<void> _migrateOldData() async {
    final jsonString = _box!.get(_splitsListKey) as String?;
    if (jsonString != null) {
      try {
        final jsonList = jsonDecode(jsonString) as List<dynamic>;
        final splits = jsonList
            .map((json) => Split.fromJson(json as Map<String, dynamic>))
            .toList();
        
        // Save each split individually
        for (final split in splits) {
          await _box!.put(split.id, split);
        }
        
        // Remove the old list key
        await _box!.delete(_splitsListKey);
      } catch (e) {
        // Log error or ignore
        print('Migration failed: $e');
      }
    }
  }

  /// Saves a single split (adds or updates).
  /// O(1) operation.
  static Future<void> saveSplit(Split split) async {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    await _box!.put(split.id, split);
  }

  /// Loads all splits from storage.
  /// O(N) but much faster than JSON decoding.
  static List<Split> loadSplits() {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    return _box!.values.whereType<Split>().toList();
    

  /// Deletes a split by ID.
  /// O(1) operation.
  static Future<void> deleteSplit(String id) async {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    await _box!.delete(id);
  }

  // Saved People
  static Future<void> savePeople(List<Map<String, dynamic>> people) async {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    final jsonString = jsonEncode(people);
    await _box!.put(_savedPeopleKey, jsonString);
  }

  static List<Map<String, dynamic>> loadPeople() {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    final jsonString = _box!.get(_savedPeopleKey) as String?;
    if (jsonString == null) return [];
    try {
      return (jsonDecode(jsonString) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  // Preferences
  static Future<void> savePreferences(Map<String, dynamic> prefs) async {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    final jsonString = jsonEncode(prefs);
    await _box!.put(_preferencesKey, jsonString);
  }

  static Map<String, dynamic>? loadPreferences() {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }
    final jsonString = _box!.get(_preferencesKey) as String?;
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}
