# Changelog

## 0.1.0

### Breaking
- Requires Dart 3.13 and Flutter 3.47 or newer.
- Depends on `bond_core: ^0.1.0` (material_ui based).
- `Rules.dateAfter(date)` now returns a `DateAfter` rule. It used to return `DateBefore` by mistake,
  so forms that relied on the old (inverted) result must be checked.

### Changed
- `mime` range widened to `>=1.0.5 <3.0.0` (mime 2 is supported).
- Dev dependency `intl_translation` `^0.20.0` -> `^0.22.0` (0.20 does not resolve on Dart 3.13).
- Library names removed (`library;`), lint fixes for `flutter_lints` 6, code formatted with the Dart 3.13 formatter.

### Fixed
- `Rules.dateAfter` returned a `DateBefore` rule (see Breaking).

## 0.0.22+19
* Added insertAsyncDropDownItem method to support dynamic item injection into async dropdowns
* Added updateAsyncDropDownItem method to update existing dropdown item labels
* Added internal caching support for async dropdown items
* Improved async dropdown flow to support inline item creation without refetching
* Added documentation for new item insertion and update methods
* Form status downgrade after submission or failure and then any field updated
* Added `replaceAsyncDropDownItems` method to `FormControllerUpdateItemsExtension`
* Added
  •	Async Radio Group Field Utilities
  •	insertAsyncRadioItem<T> — Inserts a new cached async radio item at a specific index without refetching from the API.
  •	updateAsyncRadioItem<T> — Updates the label of an existing async radio item by its value.
  •	replaceAsyncRadioItems<T> — Replaces all cached async radio items with a new list.
* Corrected validation to run against the updated (touched) field
* Skip Empty Set and List values in `body()` method
* return `jsonDecode` for collections not raw `String` on `body()` method
* Support `rules` on `HiddenFieldState`
* Fix `OptioalRule` to work with `Iterable` types like `List` and `Set`
* Fix `RequiredIfRule` to work with `Iterable` types like `List` and `Set`.

## 0.0.21+4
* Fix `setError` method from `BaseFormController`.

## 0.0.20
* Fix `updateValue` error logic method from `BaseFormController`.

## 0.0.19
* Remove forced `touched` update in form field value changes

## 0.0.18
* Fix `updateValue` error logic method from `BaseFormController`.

## 0.0.17
* Fix `updateValue` method from `BaseFormController`.

## 0.0.16
* Sync text controller on state updates for `TextFieldState`.

## 0.0.15
* Refine form field update and validation logic.

## 0.0.14
* Added new `BetweenValue` rule to validate if a field value is between two specified values.
* Updated `MaxValue` and `MinValue` rules to support `String` types.

## 0.0.13

* Added type safety validation in field listeners
* Enhanced error messages for type mismatches
* Added runtime type checking for field values and listeners
* Improved debugging capabilities for field type mismatches

## 0.0.12

* Improved type safety in field listeners
* Enhanced field value type checking in notifyFieldListeners
* Updated removeFieldListener to support generic types

## 0.0.11

* Refactored field tracking logic into separate `FieldChangeTrackingMixin`
* Enhanced form state management with improved field tracking
* Added `resetInitialFieldsValue` method to reset tracking state
* Added field change tracking with `hasFieldChanged` method
* Improved handling of field value listeners
* Added clear method override to reset initial field values

## 0.0.10+6
- Updated `intl` dependency to `^0.20.2` to ensure compatibility with the latest Flutter versions.

## 0.0.10+5
- Added `resolveAsyncField<T>(fieldName)` method on `BaseFormController` to resolve and update `AsyncHiddenFieldState<T>` values.
- Returned `Future<T>` allows awaiting the resolved value in the UI or controller logic.
- Automatically updates field value and clears error on success; captures and logs error on failure.
- Marked `pendingValue` in `AsyncHiddenFieldState<T>` as `@internal` to enforce controlled access and avoid misuse.

## 0.0.10+4
- Added `updateAsyncHiddenField`, `asyncHiddenField`, `asyncHiddenFieldValue` and required `asyncHiddenFieldValue` methods to `XFormController` and `XBondFormState` extensions respectively to support async hidden fields.

## 0.0.10+3
- Added `AsyncHiddenFieldState` to support hidden form fields with asynchronously loaded values

## 0.0.10+2
- Fixed: Avoided redundant API calls on screen pop by using state.`fields` instead of `fields()` inside the `dispose()` method.

## 0.0.10+1
- Fix `body` method to not ignore zero values even when `ignoreEmptyValues` set to true.

## 0.0.10
- Added support for `ignoredBodyKeys` to allow excluding specific fields from the request body.
- Added `ignoreEmptyValues` flag to automatically skip null, empty String, or zero int values in the final body.
- Added `remapKeys` to allow field name remapping in the output body (e.g., 'paymentMethod' → 'paymentDetails').
- Added `mergeNestedMaps` to flatten nested `Map<String, dynamic>` into the root body when needed.
- Added `postProcessBody(Map<String, dynamic>)` for custom final cleanup of the body map before sending.
- Supported nullable transformation in `registerForField` to allow clean handling of optional or missing values in field transformations.

## 0.0.9+8
 - Fix `updateError` method.

## 0.0.9+7
- Remove `clearField()` and enhanced `updateValue()` to support null values using `copyWithNullable`, simplifying API and ensuring consistent handling across field types.

## 0.0.9+6
- Implement `clearField(String field)` method to help set null values for fields.

## 0.0.9+5
- Fix `updateRadioGroupItems` method.

## 0.0.9+4
- Fix `updateRadioGroupItems` method.

## 0.0.9+3
- Added `updateRadioGroupItems` method to `XFormController` extension in `form_controller_extension.dart` to allow updating a `RadioGroupFieldState` with a list of `RadioButtonFieldState` items.

## 0.0.9+2
- Introduce `AsyncRadioGroupFieldState` to support asynchronous fetching of radio button group items.

## 0.0.9+1
- Improved form controller resource cleanup by ensuring text field listeners are removed for all TextFieldState fields in FormController.dispose().

## 0.0.9
- Added Disposable mixin to support proper resource cleanup for form states.

## 0.0.8+1
- Fix a bug `BaseFormController` on failure and the error type was not from the provided type.

## 0.0.8

### Added
- Support for field key–specific transformations in `TransformersRegistry`.
- New method `registerForField` to register transformers tied to a specific field name.

### Changed
- `BodyConvertible` now passes the `fieldKey` to the transformer for prioritized key-based transformation.

### Example
You can now add country code like this:
```dart
registry.registerForField<String, String>('phoneNumber', (value) => '+974$value');
```

## 0.0.7+1
###  Fixes

- Fixed a timing issue where `onSuccess` and `onFailure` could conflict with internal `state` updates.
- `onSuccess` / `onFailure` are now executed inside a `Future.microtask(...)` to ensure state changes (like `status`, `success`, or `failure`) are fully applied before triggering user-defined logic.
- This improves UI consistency and prevents rare bugs where `setError()` or `updateField()` had no visible effect when called immediately after submission failure.

- ## 0.0.7
### ✨ Features

- **Lifecycle Hooks for Submission**
    - Added `onSuccess(Success result)` to `BaseFormController`: triggered when form submission is successful.
    - Added `onFailure(Failure error)` to `BaseFormController`: triggered when submission fails or throws.
    - These methods can now be optionally overridden inside your controller class.
    - Eliminates the need for manually listening to form state externally.

### 🧠 Developer Experience

- Improves readability and centralizes post-submit logic inside the controller.
- Especially helpful for frameworks like GetX where external listeners (e.g., `ever`) were previously needed.

### ✅ Example:

```dart
@override
void onSuccess(MyResponse res) => Get.toNamed('/home');

@override
void onFailure(ServerError err) => Get.snackbar('Error', err.message);
```

## 0.0.6+4
- fix `BodyConvertible` `error` generics type to be extends any `Error`.

## 0.0.6+3
- fix `TextFieldStaten` that's clear `_controller` on `copyWith` method when `value` is null.

## 0.0.6+2
 - export missing `form_controller_text_field_extension` extension.

## 0.0.6+1
- Introduced a private `_controller` to avoid direct external access to the controller.
 - Developers are now encouraged to access the controller only via the `textFieldController()` method on the controller. A
 - Added `disposeTextFieldListener(fieldName)` to remove listeners manually.

## 0.0.6
- Add `TextEditingController` to `TextFieldState`.

## 0.0.5
### Breaking Changes
- Renamed `update` method to `updateField` in `GetxFormController` to avoid conflict with `GetxController`.
- This change requires updating all instances where the `update` method was used to `updateField`.

## 0.0.4+1
- Downgraded `intl` from `^0.20.2` to `^0.19.0` to fix compatibility issues with Flutter.

## 0.0.4

### Changed
- **meta:** Upgraded from `^1.8.0` to `^1.15.0`.
- **mime:** Upgraded from `^1.0.5` to `^2.0.0`.
- **intl:** Upgraded from `^0.19.0` to `^0.20.2`.
- **bond_core:** Upgraded from `^0.0.2` to `^0.0.3`.

## 0.0.3+1 
- Introduced BaseFormController mixin to handle common form state logic and provide reusable form management functions.

## 0.0.3+1
* add missing method `optional` on `rules.dart` file

## 0.0.3
### Added
- **Optional Rule**: Introduced the `Optional` validation rule that allows fields to be marked as optional. If the field is not present (null, empty string, or empty list), validation will pass, and all other rules will be skipped. If the field is present, other rules will be validated against the value.
- **Enhanced Validation Logic**: The `validate` method in `FormFieldState` now properly handles the `Optional` rule, ensuring that optional fields can skip validation when appropriate.

### Changed
- **General Validation Logic**: Updated the general validation logic to support the new `Optional` rule, improving flexibility and making form validation more intuitive for optional fields.

### Fixed
- **Bug Fixes**: Resolved issues related to handling `null` and empty values in form validation, ensuring that the new `Optional` rule operates smoothly within the validation pipeline.

## 0.0.2

* Automatic Body Generation with BodyConvertible Mixin
•	Introduced the BodyConvertible mixin, which allows automatic generation of a request body map from form state values. This simplifies the process of extracting and transforming form field values into a key-value map suitable for API requests.
•	The body() method automatically iterates over all form fields, applying registered transformers to generate the body map.

* Flexible Field Transformers with TransformersRegistry
  •	Added the TransformersRegistry class, which allows developers to register custom field transformers. These transformers can convert field values into any desired format, such as converting enum values to strings.
  •	The registry supports both single values and collections (e.g., Set, List), automatically handling the transformation of collection elements.

## 0.0.1+30
* update dependence

## 0.0.1+29

* add `setError` method to `FormController` mixin to set the error message of a specific field.
* add `updateError` method to `FormController` mixin to update the error message of a specific
  field.
* The `setError` method directly sets a provided error message for a field, while the `updateError`
  method appends the provided error message to any existing validation errors for the field.

## 0.0.1+28

* Fix isTrue & isFalse rules to deal with null value and now support bool, String & num types.

## 0.0.1+27

* Added date field support to form extensions.
    - `BondFormState` updated with methods to handle date fields.
        - `dateFieldValue`: Retrieves the value of a date field.
        - `dateField`: Retrieves the state of a date field using a simplified `get` method.

## 0.0.1+26

* Added `FileFieldState` class to manage the state of file form fields.
    - `FileFieldState` provides a way to manage file input fields within a form.

## 0.0.1+25

- **Refactor**: Separated field state and value retrieval methods into distinct files.
    - Moved field state retrieval methods to `bond_form_extensions.dart`.
    - Moved value retrieval methods to `bond_form_values.dart`.
- **Enhancement**: Updated `required_values.dart` to include the `RequiredValues` class for
  mandatory field checks.
- **Improvement**: Improved overall code organization and maintainability by dividing
  responsibilities into specific files.

## 0.0.1+24

* fix `valid` method logic.

## 0.0.1+23

* `valid` New method on `BondFormState` to check a specific field validate.

## 0.0.1+22

* Added `HiddenFieldState` class to manage the state of hidden form fields.
    - `HiddenFieldState` provides a way to manage hidden input fields within a form.
* Updated `BondFormState` with methods to handle hidden fields.
    - `hiddenFieldValue`: Retrieves the value of a hidden field.
    - `hiddenField`: Retrieves the state of a hidden field using a simplified `get` method.
* Updated `RequiredValues` class to ensure hidden field values are not null.
    - `hiddenFieldValue`: Ensures the value of a hidden field is not null.
* Updated `FormController` with methods to update hidden field values.
    - `updateHiddenField`: Updates a `HiddenFieldState` with a given value.

## 0.0.1+21

* Added the `RequiredValues` class to ensure required form field values are not null.
    - Methods added to `RequiredValues` class:
        - `textFieldValue`: Ensures the value of a text field is not null.
        - `radioGroupValue`: Ensures the value of a radio group field is not null.
        - `checkboxGroupValue`: Ensures the first selected value of a checkbox group is not null.
        - `dropDownValue`: Ensures the value of a dropdown field is not null.
        - `asyncDropDownValue`: Ensures the value of an async dropdown field is not null.
* Added the `required` extension method to `BondFormState`.
    - Provides an instance of `RequiredValues` to ensure required field values are not null.
* Updated the Dartdoc comments for `XBondFormState` extension.
    - Provided clear and comprehensive documentation for all methods:
        - `textFieldValue`: Retrieves the value of a text field.
        - `radioGroupValue`: Retrieves the value of a radio group field.
        - `checkboxGroupValue`: Retrieves the first selected value of a checkbox group.
        - `dropDownValue`: Retrieves the value of a dropdown field.
        - `asyncDropDownValue`: Retrieves the value of an async dropdown field.
        - `required`: Returns an instance of `RequiredValues` to ensure required field values are
          not null.
* Updated the Dartdoc comments for `XFormController` extension.
    - Provided clear and comprehensive documentation for all methods:
        - `updateText`: Updates a `TextFieldState` with a given value.
        - `updateCheckbox`: Updates a `CheckboxFieldState` with a given value.
        - `updateCheckboxGroup`: Updates a `CheckboxGroupFieldState` with a given value.
        - `toggleCheckbox`: Toggles the value of a specific checkbox within a checkbox group.
        - `updateDate`: Updates a `DateFieldState` with a given value.
        - `updateDropDown`: Updates a `DropDownFieldState` with a given value.
        - `updateAsyncDropDown`: Updates a `AsyncDropDownFieldState` with a given value.
        - `updateRadioButton`: Updates a `RadioButtonFieldState` with a given value.
        - `updateRadioGroup`: Updates a `RadioGroupFieldState` with a given value.

## 0.0.1+20

* fix `IsTrue` and `IsFalse` rules to deal with null value.

## 0.0.1+19

* fix `Numeric` rule to deal with null value.

## 0.0.1+18

* new extension methods support dealing with single bool checkbox field.
* fix `AlphaNum` and `AlphaDash` rules to deal with null value.

## 0.0.1+17

* fix failure handling at the _onSubmit method.

## 0.0.1+16

* introduce `HasValidationErrors` mixin to update form fields state with the errors that comes from
  an api. services.

## 0.0.1+15

* add missing method 'updateAsyncDropDown' to `FormController` extension.

## 0.0.1+14

* introduced the async drop down menu field state `AsyncDropDownFieldState`.

## 0.0.1+13

* add more helpers methods inside `BondFormState` extension

## 0.0.1+12

* add clear method to `FormController` mixin

## 0.0.1+11

* add validate method to `FormController` mixin

## 0.0.1+10

* update readme.md file to mention the riverpod integration

## 0.0.1+9

* fix typo on readme.md file

## 0.0.1+8

* update readme.md files
* fix dart analysis issues

## 0.0.1+7

* update example.md and readme.md files

## 0.0.1+6

* fix validation localized message not rendered as excepted

## 0.0.1+5

* extract mixin FormController contains common form logic

## 0.0.1+4

* write public API has dartdoc comments
* fix dart analysis issues

## 0.0.1+3

* add necessary imports to bond form

## 0.0.1+2

* update bond_core dependency.

## 0.0.1+1

* add necessary imports to bond form

## 0.0.1

* initial release.

