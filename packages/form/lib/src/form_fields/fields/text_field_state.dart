import 'package:bond_form/src/form_fields/form_field_state.dart';
import 'package:bond_form/src/validation/validation_rule.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:meta/meta.dart';

/// Represents the state of a text input form field.
///
/// A text input form field extends the [FormFieldState] class and uses a
/// [TextEditingController] to maintain a live connection with a `TextFormField`.
class TextFieldState extends FormFieldState<String?> with Disposable {
  /// A controller to manage the current text being edited.
  ///
  /// This controller is auto-initialized with the value passed to [TextFieldState].
  /// You can bind this directly to a [TextFormField] or [TextField] widget.
  final widgets.TextEditingController _controller;

  /// A focus node to manage the focus state of the text input field.
  ///
  /// This is useful for managing focus behavior in the UI, such as moving focus to the
  /// next field or handling keyboard input.
  final widgets.FocusNode _focusNode;

  @internal
  widgets.TextEditingController get controller => _controller;

  @internal
  widgets.FocusNode get focusNode => _focusNode;

  /// Creates a new instance of [TextFieldState].
  ///
  /// - [value]: The initial value of the text input field.
  /// - [label]: The label or name of the text input form field (required).
  /// - [rules]: The list of validation rules to apply to the text field (default is an empty list).
  /// - [validateOnUpdate]: Indicates whether validation should occur on updates (default is `true`).
  /// - [touched]: Indicates whether the field has been touched (interacted with) by the user (default is `false`).
  /// - [controller]: Optionally provide your own [TextEditingController]. If not provided, one will be created.
  TextFieldState(
    String? value, {
    required super.label,
    super.error,
    super.rules = const [],
    super.validateOnUpdate = true,
    super.touched,
    widgets.TextEditingController? controller,
    widgets.FocusNode? focusNode,
  }) : _controller =
           controller ??
           widgets.TextEditingController.fromValue(
             widgets.TextEditingValue(
               text: value ?? '',
               selection: value != null
                   ? widgets.TextSelection.collapsed(offset: value.length)
                   : const widgets.TextSelection.collapsed(offset: 0),
             ),
           ),
       _focusNode = focusNode ?? widgets.FocusNode(),
       super(value: value);

  @override
  TextFieldState copyWith({
    String? value,
    String? error,
    String? label,
    bool? touched,
    bool? validateOnUpdate,
    List<ValidationRule<String?>>? rules,
  }) {
    final newValue = value ?? this.value;
    _syncController(newValue);
    return TextFieldState(
      newValue,
      error: error ?? this.error,
      label: label ?? this.label,
      touched: touched ?? this.touched,
      validateOnUpdate: validateOnUpdate ?? this.validateOnUpdate,
      rules: rules ?? this.rules,
      controller: _controller,
      focusNode: _focusNode,
    );
  }

  @override
  TextFieldState updateError(String? error) {
    _syncController(value);
    return TextFieldState(
      value,
      error: error,
      label: label,
      rules: rules,
      touched: touched,
      validateOnUpdate: validateOnUpdate,
      controller: controller,
      focusNode: focusNode,
    );
  }

  @override
  TextFieldState copyWithNullable({String? value}) {
    _syncController(value);
    return TextFieldState(
      value,
      error: error,
      label: label,
      rules: rules,
      touched: touched,
      validateOnUpdate: validateOnUpdate,
      controller: controller,
      focusNode: focusNode,
    );
  }

  void _syncController(String? newValue) {
    final text = newValue ?? '';
    if (_controller.text != text) {
      _controller.value = widgets.TextEditingValue(
        text: text,
        selection: widgets.TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
  }
}
