import 'package:flutter/widgets.dart';

/// Provides an intuitive method to determine the type of device being used.
///
/// Usage:
/// ```dart
/// final deviceType = context.deviceType;
/// if (deviceType == DeviceType.tablet) {
///   // Do something specific for tablets
/// }
/// ```
extension DeviceTypeContext on BuildContext {
  DeviceType get deviceType {
    final width = MediaQuery.of(this).size.shortestSide;
    if (width < 600) {
      return DeviceType.phone;
    } else if (width >= 600 && width <= 900) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}

enum DeviceType { phone, tablet, desktop }
