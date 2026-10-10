## Basic usage:

```dart
final loginForm = FormStateNotifier<String, Error>(
  fields: {
    'email': TextFieldState(null, label: 'Email'),
    'password': TextFieldState(null, label: 'Password'),
  },
);

// Update the form fields
loginForm.updateText('email', 'johndoe@gmail.com');
loginForm.updateText('password', 'password123');

// Print the updated values
print('Email value: ${loginForm.textFieldValue('email')}');
print('Password value: ${loginForm.textFieldValue('password')}');

// Let's assume we want to submit the form now
loginForm.submit();
```

## Documentation

For a comprehensive guide on how to use `form_bond`, please refer to the full documentation available in the `bond_docs` repository under the `forms.md` file.

[Read Full Documentation Here](https://github.com/flutterbond/bond-docs/blob/main/forms.md)

