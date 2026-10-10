import 'dart:developer';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:example/features/auth/data/errors/account_not_found_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormController extends FormStateNotifier<String, Error> {
  @override
  Map<String, FormFieldState> fields() => {
    'email': TextFieldState(
      null,
      label: 'Email',
      rules: [Rules.required(), Rules.email()],
    ),
    'password': TextFieldState(
      null,
      label: 'Password',
      rules: [Rules.required(), Rules.minLength(6), Rules.alphaNum()],
    ),
  };

  @override
  Future<String> onSubmit() async {
    final email = state.get('email').value;
    final password = state.get('password').value;
    log('email: $email, password: $password');
    await Future.delayed(const Duration(seconds: 1));
    if (email != 'salahnahed@icloud.com') {
      throw AccountNotFoundError();
    }
    return 'Success';
  }
}

final loginProvider =
    NotifierProvider.autoDispose<
      LoginFormController,
      BondFormState<String, Error>
    >(LoginFormController.new);
