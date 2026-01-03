import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/split.dart';

/// Service for Hive local storage operations.
class HiveService {
  HiveService._();

  static Box? _box;

  /// Initializes Hive and opens the splits box.
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(AppConstants.splitsBoxName);
  }

  static const String _splitsListKey = 'splits_list';
  static const String _savedPeopleKey = 'saved_people';
  static const String _preferencesKey = 'preferences';

  /// Saves all splits to storage.
  static Future<void> saveSplits(List<Split> splits) async {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }

    final jsonList = splits.map((split) => split.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _box!.put(_splitsListKey, jsonString);
  }

  /// Loads all splits from storage.
  static List<Split> loadSplits() {
    if (_box == null) {
      throw StateError('HiveService not initialized. Call init() first.');
    }

    final jsonString = _box!.get(_splitsListKey) as String?;
    if (jsonString == null) {
      return [];
    }

    try {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => Split.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Saves a single split (adds or updates).
  static Future<void> saveSplit(Split split) async {
    final splits = loadSplits();
    final index = splits.indexWhere((s) => s.id == split.id);
    if (index >= 0) {
      splits[index] = split;
    } else {
      splits.add(split);
    }
    await saveSplits(splits);
  }

  /// Deletes a split by ID.
  static Future<void> deleteSplit(String id) async {
    final splits = loadSplits();
    splits.removeWhere((s) => s.id == id);
    await saveSplits(splits);
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
