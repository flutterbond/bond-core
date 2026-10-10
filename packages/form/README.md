# Bond Form

The `bond_form` package provides a robust and flexible solution to manage form state in Flutter applications. It
introduces several classes and utilities that simplify the process of validation, submission, and error handling in
forms.

This package is ideal for anyone looking to streamline their form management logic, whether it's for a simple login form
or a complex, multi-step registration process.

[![Pub Version](https://img.shields.io/pub/v/bond_form)](https://pub.dev/packages/bond_form)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

# Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Easy to use API for form management
- Built-in validation logic
- Customizable form fields
- Reactive state management
- Support for async form submission
- Easily extensible

## Installation

To use `bond_form`, simply add it as a dependency in your `pubspec.yaml`:

```yaml
dependencies:
  bond_form: ^0.0.1
```
if you want to use the riverpod integration, add the following dependency:
```yaml
dependencies:
  bond_form_riverpod: ^0.0.1
```
and no need to add the bond_form dependency, it will be added automatically.

## Usage:

```dart

final loginForm = BondFormState<String, Error>(
  fields: {
    'email': TextFieldState(
      null,
      label: 'Email',
      rules: [
        Rules.required(),
        Rules.email(),
      ],
    ),
    'password': TextFieldState(
      null,
      label: 'Password',
      rules: [
        Rules.required(),
        Rules.minLength(8),
      ],
    ),
  },
);

final loginController = LogiFormController();

void main() {
  // Update the form fields
  loginController.updateText('email', 'salahnahed@icloud.com');
  loginController.updateText('password', 'password123');

// Print the updated values
  print('Email value: ${loginForm.textFieldValue('email')}');
  print('Password value: ${loginForm.textFieldValue('password')}');

// Let's assume we want to submit the form now
  loginController.submit();
}
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs`
repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/flutterbond/bond-docs/blob/main/forms.md)

## Contributing

Contributions are welcome! However, we currently do not have a set guideline for contributions. If you're interested in
contributing, please feel free to open a pull request or issue, and we'll be happy to discuss and review your changes.

## License

Bond Core is licensed under the [MIT License](LICENSE).
