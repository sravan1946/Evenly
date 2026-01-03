import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/preferences.dart';
import '../../data/local/hive_service.dart';

/// Provider for app preferences.
final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, AppPreferences>((ref) {
  final notifier = PreferencesNotifier();
  notifier.loadPreferences();
  return notifier;
});

/// State notifier for managing preferences.
class PreferencesNotifier extends StateNotifier<AppPreferences> {
  PreferencesNotifier() : super(const AppPreferences());

  /// Loads preferences from storage.
  void loadPreferences() {
    final json = HiveService.loadPreferences();
    if (json != null) {
      state = AppPreferences.fromJson(json);
    }
  }

  /// Updates theme preference.
  Future<void> setTheme(String theme) async {
    state = state.copyWith(theme: theme);
    await _saveToStorage();
  }

  /// Updates currency preference.
  Future<void> setCurrency(String currency) async {
    state = state.copyWith(currency: currency);
    await _saveToStorage();
  }

  /// Updates rounding preference.
  Future<void> setRounding(String rounding) async {
    state = state.copyWith(rounding: rounding);
    await _saveToStorage();
  }

  Future<void> _saveToStorage() async {
    await HiveService.savePreferences(state.toJson());
  }
}
