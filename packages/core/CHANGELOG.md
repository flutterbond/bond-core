## Changelog

## 0.1.0

### Breaking
- Requires Dart 3.13 and Flutter 3.47 or newer.
- `ThemeContext` and `ScaffoldContext` now use the types of `package:material_ui`
  (`TextTheme`, `ColorScheme`, `ThemeData`, `SnackBar`, `ScaffoldMessenger`) instead of
  `package:flutter/material.dart`. Migrate app imports with
  `dart fix --apply --code=migrate_design_widgets`.
- Removed the `ThemeContext.buttonTheme` getter (legacy `ButtonThemeData`). Use
  `Theme.of(context).buttonTheme` if you still need it.

### Changed
- `get_it` range widened to `>=8.0.3 <10.0.0` (get_it 9 is supported).
- Added the `material_ui: ^1.6.0` dependency.
- `InsetsContext` imports `package:flutter/widgets.dart` only.

### Fixed
- `ThemeContext.textTheme` doc example used the removed `bodyText1`; it now shows `bodyLarge`.

## 0.0.3

### Changes

- **Dependency Update**:
    - Bumped `get_it` from `^7.6.4` to `^8.0.3`.

> **Note**: This update should be seamless if you aren’t using any breaking changes introduced in `get_it` 8.0. However, if you rely on advanced `get_it` features, consult the official `get_it` documentation to ensure compatibility with the new version.

## 0.0.2

### Migration Guide

1. **Update Override of `responseConvert`**:
   If you previously overrode the `responseConvert` method, update your implementation to use
   the `factories` getter instead.

   **Before**:
   ```dart
   class MyServiceProvider with ResponseDecoding {
     @override
     T? responseConvert<T>(Map<String, dynamic> json) {
       if (T == MyModel) {
         return MyModel.fromJson(json) as T;
       }
       // Add other model conversions as needed...
       return null;
     }
   }
   ```

   **After**:
   ```dart
   class MyServiceProvider with ResponseDecoding {
     @override
     Map<Type, JsonFactory> get factories => {
       MyModel: (json) => MyModel.fromJson(json),
       AnotherModel: (json) => AnotherModel.fromJson(json),
       // Add other model factories as needed...
     };
   }
   ```

2. **Remove Direct Calls to `responseConvert`**:
   Ensure that you no longer directly call or override `responseConvert`. Instead, rely on the
   default implementation provided by the mixin.

## 0.0.1+9

* add new extensions to map a `Future` results.

## 0.0.1+8

* appKey now from type GlobalKey<NavigatorState>.

## 0.0.1+7

* call WidgetsFlutterBinding.ensureInitialized method before init the service providers.

## 0.0.1+6

* take providers list as a method argument on run method.

## 0.0.1+5

* just format files using dart form command.

## 0.0.1+4

* add missing repository property at pubspec.yaml file.

## 0.0.1+3

#### Breaking Changes:

- Refactored `ServiceProvider`.
    - Removed `responseConvert<T>` method.
    - Added `ResponseDecoding` mixin. Use its `convertResponse<T>` method for response conversion.

#### How to Migrate:

1. If you used `responseConvert<T>`, replace it with the `convertResponse<T>` method from the
   new `ResponseDecoding`
   mixin.

```dart
// Old:
class MyServiceProvider extends ServiceProvider {
  @override
  T? responseConvert<T>(Map<String, dynamic> json) {
    ...
  }
}

// New:
class MyServiceProvider extends ServiceProvider with ResponseDecoding {
  @override
  T? convertResponse<T>(Map<String, dynamic> json) {
    ...
  }
}
```

#### Added

- **Utils Extensions**:
    - `ThemeContext`: Directly access `textTheme` and `colorScheme`.
    - `ScaffoldContext`: Convenient methods like `showSnackBar` added.
    - `KeyboardContext`: Methods to control and check the keyboard state.
    - `InsetsContext`: Access media padding, status bar height, and bottom inset.
    - `LocalizationContext`: Access the current locale of the context.
    - `MediaQueryContext`: Determine `screenHeight`, `screenWidth`, and if the device orientation is
      landscape.
    - `DeviceTypeContext`: Determine if the device is a phone, tablet, or desktop.
    - `TextScaleContext`: Access text scale factors for accessibility settings.
    - `BrightnessContext`: Check if the device is in dark mode or light mode.
    - `SafeAreaContext`: Access the safe area insets.

#### Updated

- **App Initialization**:
    - Introduced `RunTasks` class to streamline application start-up process. The usage has been
      refactored to use `run`
      with `RunTasks` for initialization logic, including registering service providers and other
      pre and post-run
      tasks.
        - Example:
          ```dart
          void main() => run(
            () => const ProviderScope(
              child: BondApp(),
            ),
            RunAppTasks(providers),
          );
          ```
    - The `RunTasks` class now initializes service providers through a callable method.
    - `beforeRun`, `afterRun`, and `onError` methods of `RunTasks` are now optional.

## 0.0.1+2

* remove device_info package.
* remove device_utils.dart file.
* remove string_extension.dart file.

## 0.0.1+1

* fix package description.

## 0.0.1

* initial release.