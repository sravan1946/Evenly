/// App-wide constants.
class AppConstants {
  AppConstants._();

  /// Standard spacing values (8px base unit).
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 24.0;
  static const double spacingXXL = 32.0;

  /// Animation durations.
  static const Duration animationShort = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);

  /// Hive box name.
  static const String splitsBoxName = 'splits';
  static const String currentSplitKey = 'current_split';
}
