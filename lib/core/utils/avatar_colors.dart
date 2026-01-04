import 'dart:ui';

/// Utility class for generating and managing avatar colors.
class AvatarColors {
  AvatarColors._();

  /// Predefined palette of beautiful, accessible colors for avatars.
  static const List<int> palette = [
    0xFF6366F1, // Indigo
    0xFFEC4899, // Pink
    0xFF14B8A6, // Teal
    0xFFF59E0B, // Amber
    0xFF8B5CF6, // Violet
    0xFF10B981, // Emerald
    0xFFF97316, // Orange
    0xFF06B6D4, // Cyan
    0xFFEF4444, // Red
    0xFF3B82F6, // Blue
    0xFF84CC16, // Lime
    0xFFDB2777, // Fuchsia
    0xFF2563EB, // Blue-600
    0xFF059669, // Emerald-600
    0xFFDC2626, // Red-600
    0xFF7C3AED, // Violet-600
  ];

  /// Generates a color based on the person's name for consistency.
  static int getColorForName(String name) {
    if (name.isEmpty) return palette[0];
    
    // Use hashCode for consistent color assignment
    final hash = name.toLowerCase().hashCode.abs();
    return palette[hash % palette.length];
  }

  /// Returns a random color from the palette.
  static int getRandomColor() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return palette[now % palette.length];
  }

  /// Converts hex int to Color.
  static Color toColor(int hexValue) {
    return Color(hexValue);
  }

  /// Gets contrasting text color (white or black) for readability.
  static Color getContrastingTextColor(int hexValue) {
    final color = Color(hexValue);
    // Calculate luminance
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  /// Gets initials from a name (max 2 characters).
  static String getInitials(String name) {
    if (name.isEmpty) return '?';
    
    final words = name.trim().split(' ').where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }
    
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }
}
