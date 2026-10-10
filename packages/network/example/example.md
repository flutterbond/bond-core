# Bond Core Example

This document provides a simple example of how to use the Bond Core package in your Flutter application.

## Setup

1. First, ensure you have the package added to your `pubspec.yaml`:

```yaml
dependencies:
  bond_core: ^latest_version
```

2. Import the necessary packages in your Dart file:

```dart
import 'package:bond_core/bond_core.dart';
```

## Usage

Below is a basic example to initialize your app using the Bond Core package:

```dart
void main() =>
    run(
          () =>
      const ProviderScope(
        child: BondApp(),
      ),
      RunAppTasks(appProviders),
    );

final List<ServiceProvider> providers = [
  // Framework Service Providers
  FirebaseServiceProvider(),
  AppServiceProvider(),
  AuthServiceProvider(),
  ApiServiceProvider(),
  CacheServiceProvider(),
  AnalyticsServiceProvider(),
  FormServiceProvider(),
  NotificationsServiceProvider(),

  // Modules Service Providers
  PostServiceProvider(),
  // more...
];
```

Remember, Bond Core offers a range of utilities, extensions, and other functionalities. Explore
the [official documentation](https://github.com/flutterbond/bond-docs) for comprehensive guides, tutorials, and API
references.

