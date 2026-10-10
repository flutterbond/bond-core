import 'package:material_ui/material_ui.dart';

/// Extension methods on [BuildContext] to provide easier access to theme-related properties.
extension ThemeContext on BuildContext {
  /// Retrieves the [TextTheme] from the closest [Theme] widget ancestor.
  ///
  /// ```dart
  /// final textStyle = context.textTheme.bodyLarge;
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Retrieves the [ColorScheme] from the closest [Theme] widget ancestor.
  ///
  /// ```dart
  /// final primaryColor = context.colorScheme.primary;
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Retrieves the [ThemeData] from the closest [Theme] widget ancestor.
  /// ```dart
  /// final themeData = context.themeData;
  /// ```
  ThemeData get themeData => Theme.of(this);

  /// Retrieves the [ThemeData.brightness] from the closest [Theme] widget ancestor.
  /// ```dart
  /// final brightness = context.brightness;
  /// ```
  Brightness get brightness => themeData.brightness;
}
