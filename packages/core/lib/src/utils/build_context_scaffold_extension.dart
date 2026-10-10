import 'package:material_ui/material_ui.dart';

/// Provides helper methods related to the [Scaffold] and [ScaffoldMessenger]
/// for a more convenient and streamlined way of displaying messages and dialogs.
extension ScaffoldContext on BuildContext {
  /// Shows a [SnackBar] with the given [message].
  ///
  /// Example usage:
  /// ```dart
  /// context.showSnackBar("Item added to cart!");
  /// ```
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
