# Changelog

## 0.1.0

Migrates to Riverpod 3. Riverpod 3 has one `Notifier` class for every
provider kind (`FamilyNotifier`, `AutoDisposeNotifier` and
`AutoDisposeFamilyNotifier` were removed), so the 12 notifier classes of this
package become 6. Whether a form is auto-disposed is now decided by the
provider declaration (`NotifierProvider.autoDispose`), not by the class.

### Breaking

* Requires `riverpod` ^3.0.0 (`flutter_riverpod` ^3.0.0 in apps), Dart ^3.13.0 and Flutter >=3.47.0.
* `AutoDisposeFormStateNotifier`, `AutoDisposeStepFormStateNotifier` and
  `AutoDisposeStepperFormStateNotifier` are now deprecated typedefs of
  `FormStateNotifier`, `StepFormStateNotifier` and `StepperFormStateNotifier`.
  Existing subclasses keep compiling; extend the base class instead and keep
  (or add) `NotifierProvider.autoDispose` on the provider.
* Removed `AutoDisposeFamilyFormStateNotifier`, `AutoDisposeFamilyStepFormStateNotifier`
  and `AutoDisposeFamilyStepperFormStateNotifier`. Use `FamilyFormStateNotifier`,
  `FamilyStepFormStateNotifier` and `FamilyStepperFormStateNotifier` with
  `NotifierProvider.autoDispose.family`.
* `FamilyFormStateNotifier`, `FamilyStepFormStateNotifier` and
  `FamilyStepperFormStateNotifier` now extend the matching base class and receive
  the family argument through their constructor: `MyForm(super.arg)`. The argument
  is available as the `arg` field; `build` takes no parameter any more
  (`build(Arg arg)` overrides become `build()`).
* `stopOnFirstError` is no longer redeclared as a `final` field on the notifiers;
  the constructor parameter is unchanged and sets the field of `BaseFormController`.

### Changed

* Once the provider is disposed, `state` returns the last state and writes are
  ignored (`ref.mounted` guard). An `onSubmit` that completes after the page was
  closed no longer throws `UnmountedRefException`.
* Fields are still disposed through `ref.onDispose`; reading `state` there no
  longer trips Riverpod 3's "Cannot use Ref inside life-cycles" assertion.
* Added tests (`test/form_state_notifier_test.dart`).

## 0.0.17+19
* Updated bond_form dependency to ^0.0.22+19

## 0.0.17+4
* Updated bond_form dependency to ^0.0.22+4

## 0.0.16+4
* Updated bond_form dependency to ^0.0.21+4

## 0.0.16
* Updated bond_form dependency to ^0.0.21

## 0.0.15
* Updated bond_form dependency to ^0.0.20

## 0.0.14
* Updated bond_form dependency to ^0.0.19

## 0.0.13
* Updated bond_form dependency to ^0.0.18

## 0.0.12
* Updated bond_form dependency to ^0.0.17

## 0.0.11
* Updated bond_form dependency to ^0.0.16

## 0.0.10
* Updated bond_form dependency to ^0.0.15

## 0.0.9
* Updated bond_form dependency to ^0.0.14

## 0.0.8

* Updated bond_form dependency to ^0.0.13
* Enhanced type safety with improved field listeners
* Better error messages for type mismatches

## 0.0.7

* Updated bond_form dependency to latest version
* Enhanced type safety support in form handling
* Improved Riverpod integration with generic types

## 0.0.6
* Updated to use new field tracking functionality from bond_form
* Added support for field value change tracking
* Updated dependency on bond_form to ^0.0.11

## 0.0.3+6
- Bumped `bond_form` dependency to version `^0.0.10+6`.

## 0.0.5+5
- Bumped `bond_form` dependency to version `^0.0.10+5`.

## 0.0.5+4
- Bumped `bond_form` dependency to version `^0.0.10+4`.

## 0.0.5+3
- Bumped `bond_form` dependency to version `^0.0.10+3`.

## 0.0.5+2
- Bumped `bond_form` dependency to version `^0.0.10+2`.

## 0.0.5+1
- Bumped `bond_form` dependency to version `^0.0.10+1`.

## 0.0.5
- Bumped `bond_form` dependency to version `^0.0.10`.

## 0.0.4+8
- Bumped `bond_form` dependency to version `^0.0.9+8`.

## 0.0.4+7
- Bumped `bond_form` dependency to version `^0.0.9+7`.

## 0.0.4+6
- Bumped `bond_form` dependency to version `^0.0.9+6`.

## 0.0.4+5
- Bumped `bond_form` dependency to version `^0.0.9+5`.

## 0.0.4+4
- Bumped `bond_form` dependency to version `^0.0.9+4`.

## 0.0.4+3
- Bumped `bond_form` dependency to version `^0.0.9+3`.

## 0.0.4+2
- Bumped `bond_form` dependency to version `^0.0.9+2`.

## 0.0.4+1
- Bumped `bond_form` dependency to version `^0.0.9+1`.

## 0.0.4
- Added Disposable mixin to support proper resource cleanup for form states.

## 0.0.3+10
- Bumped `bond_form` dependency to version `^0.0.8+1`.

## 0.0.3+9
- Bumped `bond_form` dependency to version `^0.0.8`.

## 0.0.3+8
- Bumped `bond_form` dependency to version `^0.0.7+1`.

## 0.0.3+7
- Bumped `bond_form` dependency to version `^0.0.7`.

## 0.0.3+6
- Bumped `bond_form` dependency to version `^0.0.6+4`.

## 0.0.3+5
- Bumped `bond_form` dependency to version `^0.0.6+3`.

## 0.0.3+4
- Bumped `bond_form` dependency to version `^0.0.6+2`.

## 0.0.3+3
- Bumped `bond_form` dependency to version `^0.0.6+1`.

## 0.0.3+2
- Bumped `bond_form` dependency to version `^0.0.6`.

## 0.0.3+1
- Bumped `bond_form` dependency to version `^0.0.5`.

## 0.0.3
- Bumped `riverpod` dependency to version `^2.6.1`.
- Bumped `bond_form` dependency to version `^0.0.4`.

## 0.0.1+6

* update riverpod dependency.

## 0.0.1+5

* export missing files.

## 0.0.1+4

* support FamilyFormStateNotifier and AutoDisposeFamilyFormStateNotifier.

## 0.0.1+3

* update readme file.

## 0.0.1+1

* add repository link to pubspec.yaml.

## 0.0.1

* initial release.

