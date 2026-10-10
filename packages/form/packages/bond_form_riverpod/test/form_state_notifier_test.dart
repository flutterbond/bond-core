import 'dart:async';

import 'package:bond_form/bond_form.dart';
import 'package:bond_form_riverpod/bond_form_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

class _LoginForm extends FormStateNotifier<String, Error> {
  int disposeCount = 0;
  Completer<String>? pendingSubmit;

  @override
  Map<String, FormFieldState> fields() => {
    'email': TextFieldState(null, label: 'Email'),
    'password': TextFieldState(null, label: 'Password'),
  };

  @override
  Future<String> onSubmit() => (pendingSubmit = Completer<String>()).future;

  @override
  void dispose() {
    disposeCount++;
    super.dispose();
  }
}

class _ProfileForm extends FamilyFormStateNotifier<String, Error, String> {
  _ProfileForm(super.arg);

  @override
  Map<String, FormFieldState> fields() => {
    'name': TextFieldState(arg, label: 'Name'),
  };

  @override
  Future<String> onSubmit() async => arg;
}

final _loginProvider =
    NotifierProvider<_LoginForm, BondFormState<String, Error>>(_LoginForm.new);

final _autoDisposeLoginProvider =
    NotifierProvider.autoDispose<_LoginForm, BondFormState<String, Error>>(
      _LoginForm.new,
    );

final _profileProvider = NotifierProvider.autoDispose
    .family<_ProfileForm, BondFormState<String, Error>, String>(
      _ProfileForm.new,
    );

void main() {
  test('build() creates the fields', () {
    final container = ProviderContainer.test();

    final state = container.read(_loginProvider);

    expect(state.fields.keys, ['email', 'password']);
    expect(state.status, BondFormStateStatus.pristine);
  });

  test('updateValue updates the state and notifies listeners', () {
    final container = ProviderContainer.test();
    final states = <BondFormState<String, Error>>[];
    container.listen(_loginProvider, (_, next) => states.add(next));

    container
        .read(_loginProvider.notifier)
        .updateValue<TextFieldState, String?>('email', 'bond@example.com');

    expect(states, hasLength(1));
    expect(
      container.read(_loginProvider).textFieldValue('email'),
      'bond@example.com',
    );
  });

  test('an .autoDispose provider calls dispose once unused', () async {
    final container = ProviderContainer.test();
    final subscription = container.listen(_autoDisposeLoginProvider, (_, _) {});
    final notifier = container.read(_autoDisposeLoginProvider.notifier);

    subscription.close();
    await container.pump();

    expect(container.exists(_autoDisposeLoginProvider), isFalse);
    expect(notifier.disposeCount, 1);
  });

  test('writes after dispose are ignored instead of throwing', () async {
    final container = ProviderContainer.test();
    final subscription = container.listen(_autoDisposeLoginProvider, (_, _) {});
    final notifier = container.read(_autoDisposeLoginProvider.notifier);

    // A submit that is still waiting for onSubmit when the page is closed.
    final submit = notifier.submit();
    expect(notifier.state.status, BondFormStateStatus.submitting);

    subscription.close();
    await container.pump();
    expect(container.exists(_autoDisposeLoginProvider), isFalse);

    notifier.pendingSubmit!.complete('token');
    await expectLater(submit, completes);
    expect(
      () => notifier.setError('email', 'Unknown account'),
      returnsNormally,
    );
    expect(notifier.state.status, BondFormStateStatus.submitting);
  });

  test('a family argument reaches the notifier', () {
    final container = ProviderContainer.test();

    expect(container.read(_profileProvider('bond').notifier).arg, 'bond');
    expect(
      container.read(_profileProvider('bond')).textFieldValue('name'),
      'bond',
    );
    expect(
      container.read(_profileProvider('core')).textFieldValue('name'),
      'core',
    );
  });
}
