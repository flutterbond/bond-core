# Bond Form Getx

Form Bond also comes with out-of-the-box integration with Getx, a popular state management solution for Flutter. Getx allows for robust state management and combines well with Form Bond's strong form handling capabilities. With this integration, Form Bond brings the simplicity of creating complex forms and the robustness of managing state effectively in Flutter applications.

[![Pub Version](https://img.shields.io/pub/v/bond_form_getx)](https://pub.dev/packages/bond_form_getx)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Core Components](#core-components)
- [Documentation](#documentation)
- [License](#license)

## Features:

1. **Seamless Integration**: Getx Form Bond offers smooth integration with Getx, allowing you to focus more on building your app and less on boilerplate code.
2. **Strong Form Handling**: Utilizing Form Bond's strong form validation and management features, it provides a complete solution for form-based Flutter applications.
3. **Reactive State Management**: With Getx's reactive state management, form state updates are efficiently handled.
4. **Flexibility**: You have the ability to customize the form behavior and validation using the `GetxFormController`.
5. **Type-Safety**: Being strongly typed, it helps catch issues at compile-time rather than runtime.

## Installation

To use `bond_form_getx`, simply add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  bond_form_getx: ^0.0.1
```

## Usage:

### Import the package

```dart
import 'package:bond_form_getx/bond_form_bloc.dart';
```

### Create a Form Controller

Extend the `GetxFormController` to create your form controller:

```dart
import 'package:get/get.dart';
import 'package:bond_form/bond_form.dart';
import 'package:bond_form_getx/bond_form_bloc.dart';

class LoginFormController extends GetxFormController<String, Error> {
  @override
  Map<String, FormFieldState> fields() => {
    'email': TextFieldState(
      null,
      label: 'Email',
      rules: [Rules.required()],
    ),
    'password': TextFieldState(
      null,
      label: 'Password',
      rules: [Rules.required()],
    ),
  };

  @override
  Future<String> onSubmit() async {
    final email = state.required().textFieldValue('email');
    final password = state.required().textFieldValue('password');
    // simulate login
    await Future.delayed(Duration(seconds: 1));
    return 'Welcome $email';
  }
}
```

### Use the Form Controller in a Widget

```dart
final controller = Get.put(LoginFormController());

Obx(() {
  final state = controller.formState.value;
  return Column(
    children: [
      TextField(
        onChanged: (value) => controller.updateField('email', value),
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: state.fields['email']?.error,
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        onChanged: (value) => controller.updateField('password', value),
        decoration: InputDecoration(
          labelText: 'Password',
          errorText: state.fields['password']?.error,
        ),
        obscureText: true,
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => controller.submit(),
        child: const Text('Login'),
      ),
    ],
  );
})
```

## Core Components:

### `GetxFormController`

An abstract class that helps you manage your form state, providing essential functionalities for form validation and submission. It extends the Getx's `GetxController` class and mixes in `FormController` for added capabilities. The state is represented as an instance of `BondFormState`, which encapsulates all the form fields and their statuses.

Example:

```dart
class MyFormController extends GetxFormController<String, MyError> {
  // Implement required methods...
}
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs` repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/flutterbond/bond-docs/blob/main/forms.md)

## Contributing

Contributions are welcome! However, we currently do not have a set guideline for contributions. If you're interested in contributing, please feel free to open a pull request or issue, and we'll be happy to discuss and review your changes.

## License

Bond Core is licensed under the [MIT License](LICENSE).
