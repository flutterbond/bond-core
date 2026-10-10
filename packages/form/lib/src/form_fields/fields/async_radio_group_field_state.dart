import 'package:bond_form/src/form_fields.dart';
import 'package:bond_form/src/validation/rules.dart';
import 'package:meta/meta.dart';

/// Represents the state of an asynchronous radio button group form field.
///
/// An asynchronous radio button group form field extends the [FormFieldState] class, providing
/// a way to manage the state of a radio button group with asynchronously loaded items.
class AsyncRadioGroupFieldState<T> extends FormFieldState<T> {
  /// The future that resolves to the list of individual radio button states within the group.
  @protected
  final Future<List<RadioButtonFieldState<T>>> items;
  List<RadioButtonFieldState<T>>? cachedItems;

  /// Creates a new instance of [AsyncRadioGroupFieldState].
  ///
  /// - [value] The initial value of the radio button group (selected item).
  /// - [items] A `Future` that resolves to the list of individual radio button states (required).
  /// - [label] The label or name of the radio button group form field (required).
  /// - [rules] The list of validation rules to apply to the radio button group field (default is an empty list).
  AsyncRadioGroupFieldState(
    T value, {
    required this.items,
    required super.label,
    super.error,
    this.cachedItems,
    super.rules,
  }) : super(value: value);

  Future<List<RadioButtonFieldState<T>>> get resolvedItems async {
    final resolved = await items;
    cachedItems = resolved;
    return resolved;
  }

  @override
  AsyncRadioGroupFieldState<T> copyWith({
    T? value,
    String? error,
    Future<List<RadioButtonFieldState<T>>>? items,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<T>>? rules,
    List<RadioButtonFieldState<T>>? cachedItems,
  }) {
    return AsyncRadioGroupFieldState<T>(
      value ?? this.value,
      items: items ?? this.items,
      cachedItems: cachedItems ?? this.cachedItems,
      label: label ?? this.label,
      rules: rules ?? this.rules,
      error: error ?? this.error,
    );
  }

  @override
  AsyncRadioGroupFieldState<T> updateError(String? error) {
    return AsyncRadioGroupFieldState<T>(
      value,
      items: items,
      cachedItems: cachedItems,
      label: label,
      rules: rules,
      error: error,
    );
  }

  @override
  AsyncRadioGroupFieldState<T> copyWithNullable({T? value}) {
    return AsyncRadioGroupFieldState<T>(
      value as T,
      items: items,
      cachedItems: cachedItems,
      label: label,
      rules: rules,
      error: error,
    );
  }
}
