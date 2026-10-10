import 'package:flutter/widgets.dart';

/// Extension methods on [BuildContext] to provide easier access to [MediaQuery] padding properties.
extension InsetsContext on BuildContext {
  /// Returns the parts of the display that contain system UI, typically areas that
  /// are not fully obscured by the system UI, such as the area at the top of the
  /// display containing the status bar and the area at the bottom containing the system nav.
  ///
  /// This can be helpful to avoid layout issues with system UI overlays like the status bar,
  /// notch, keyboard, navigation bar, etc.
  ///
  /// Example usage:
  /// ```dart
  /// final padding = context.mediaPadding;
  /// ```
  EdgeInsets get mediaPadding => MediaQuery.of(this).padding;

  /// Retrieves the height of the status bar from the top edge of the screen.
  ///
  /// This is useful when you want to adjust the layout or position of your widgets
  /// based on the status bar height, especially on devices with notches or cutouts.
  ///
  /// Example usage:
  /// ```dart
  /// final height = context.statusBarHeight;
  /// ```
  double get statusBarHeight => mediaPadding.top;

  /// Retrieves the height of the bottom inset of the screen.
  ///
  /// This can represent various system UI elements like the Android software navigation
  /// bar or the iOS home gesture area. It can be useful to adjust the layout or position
  /// of your widgets based on this inset.
  ///
  /// Example usage:
  /// ```dart
  /// final bottomSpace = context.bottomInset;
  /// ```
  double get bottomInset => mediaPadding.bottom;
}
