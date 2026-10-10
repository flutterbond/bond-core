# Bond Cache

The `bond_cache` package provides a robust and flexible solution to manage caching in Flutter applications. It
introduces several classes and utilities that simplify the process of storing, retrieving, and managing cached data.

This package is ideal for anyone looking to streamline their caching logic, whether it's for simple key-value pairs or complex custom objects.

[![Pub Version](https://img.shields.io/pub/v/bond_cache)](https://pub.dev/packages/bond_cache)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Easy to use API for caching
- Built-in support for various data types
- Customizable serialization and deserialization
- Cache drivers for different storage mechanisms
- Reactive state management: Can be extended to support reactive updates. 
- Support for async operations: Methods like put, add, forever, forget, increment, decrement, pull, remember, and rememberForever are asynchronous.
- Easily extensible

## Installation

To use `bond_cache`, simply add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  bond_cache: ^0.0.1
```

## Usage

```dart
import 'package:bond_cache/bond_cache.dart';

// Example usage
final user = Cache.get<User>('user');
Cache.put<User>('user', User(id: 1, name: 'SALAH'));
```

## Documentation

For a comprehensive guide on how to use `bond_cache`, please refer to the full documentation available in the `bond_docs`
repository under the `caching.md` file.

[Read Full Documentation Here](https://github.com/flutterbond/bond-docs/blob/main/caching.md)

## Contributing

Contributions are welcome! However, we currently do not have a set guideline for contributions. If you're interested in
contributing, please feel free to open a pull request or issue, and we'll be happy to discuss and review your changes.

## License

Bond Cache is licensed under the [MIT License](LICENSE).