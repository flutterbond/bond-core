# Bond Core

Bond Core provides foundational utilities and services for Flutter applications, including dependency injection, state
management, and many other essential utilities.

[![Pub Version](https://img.shields.io/pub/v/bond_core)](https://pub.dev/packages/bond_core)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

Bond Core offers a comprehensive set of utilities and integrations designed to streamline Flutter development and promote standardization across projects. Here are some of the prominent features:

- **Service Provider System**: Centralized and organized system for managing dependency injection using the `GetIt` service locator. Just create your service providers, add them to the `providers` list, and initialize them with the `RunAppTasks`.

- **Utility Extensions**:
    - **BuildContext Extensions**: Simplify common operations with context-aware extensions. Get media query details, theme attributes, show snack bars, and more.
    - **Responsive Layout Helpers**: Determine device type (phone, tablet, desktop), handle text scale factors, check brightness settings, and manage safe area insets to make your layouts adaptive.
    - **Future Extensions**: Provides a methods to map the result of the future to a different type.

- **App Initialization**: Use the `run` method with `RunTasks` for a streamlined app initialization process, ensuring services are registered before your app starts.

- **Error Handling**: Catch and handle application errors in a centralized manner using the provided mechanisms in `RunTasks`.

- **Localization**: Extensions to help retrieve locale details and support for multilingual applications.

- **Comprehensive Documentation**: Navigate to [Bond Docs](https://github.com/flutterbond/bond-docs) for detailed guides, tutorials, and API references.

This is just a glimpse of what Bond Core offers. Dive into the package and explore the extensive features that can expedite your Flutter development.


## Installation

Bond Core serves as the foundational package for all Bond packages. This means that when you add any Bond package to your Flutter project, `bond_core` will be automatically included as a dependency.

However, if you want to use `bond_core` standalone without other Bond packages, you can manually add it to your `pubspec.yaml`:

```yaml
dependencies:
  bond_core: ^latest_version
```

## Usage

To utilize Bond Core in your Flutter application, ensure you set up the application's entry point as demonstrated below:

```dart
import 'package:bond_core/bond_core.dart';
import 'package:bond_app/app.dart';

// main.dart file 
void main() =>
    run(
          () =>
      const ProviderScope(
        child: BondApp(),
      ),
      RunAppTasks(appProviders),
    );
```

Then, in your `configs/app.dart` file, you can set up your application's providers as follows:

```dart

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
];
```

## Documentation

Comprehensive documentation for the Bond Core package, as well as other parts of the Bond ecosystem, is available in
our [official documentation repository](https://github.com/flutterbond/bond-docs).

We highly recommend browsing through the documentation to get the most out of Bond Core and associated packages.

## Contributing

Contributions are welcome! However, we currently do not have a set guideline for contributions. If you're interested in
contributing, please feel free to open a pull request or issue, and we'll be happy to discuss and review your changes.

## License

Bond Core is licensed under the [MIT License](LICENSE).
