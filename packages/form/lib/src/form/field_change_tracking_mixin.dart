import 'package:bond_form/bond_form.dart';
import 'package:meta/meta.dart';

/// A class to maintain type safety for field listeners
class _TypedListener<T> {
  final void Function(T) callback;

  _TypedListener(this.callback);

  void call(T value) => callback(value);
}

/// A mixin that provides field value change tracking functionality for forms.
///
/// This mixin allows tracking changes in form field values by maintaining initial values
/// and providing methods to check if fields have been modified. It also supports field
/// change listeners for reactive programming patterns.
mixin FieldChangeTrackingMixin<Success, Failure extends Error>
    on BaseFormController<Success, Failure, BondFormState<Success, Failure>> {
  // Store initial field values for change tracking
  final Map<String, dynamic> _initialFieldValues = {};

  // Store field change listeners with type information
  final Map<String, List<_TypedListener>> _fieldListeners = {};

  /// Initialize field tracking for change detection
  @protected
  void initializeFieldTracking() {
    for (final entry in state.fields.entries) {
      _initialFieldValues[entry.key] = entry.value.value;
    }
  }

  /// Add a listener for a specific field's changes and returns the current field value
  void addFieldListener<T>(String fieldName, void Function(T) listener) {
    final field = state.fields[fieldName];
    if (field == null) {
      throw ArgumentError('Field "$fieldName" does not exist in the form');
    }

    // Check if the field value type matches the listener type
    if (field.value != null && field.value is! T) {
      throw ArgumentError(
        'Type mismatch in addFieldListener: Field "$fieldName" has type '
        '"${field.value.runtimeType}" but listener expects type "$T"',
      );
    }

    _fieldListeners
        .putIfAbsent(fieldName, () => [])
        .add(_TypedListener<T>(listener));
  }

  /// Remove a listener for a specific field's changes
  void removeFieldListener<T>(String fieldName, void Function(T) listener) {
    _fieldListeners[fieldName]?.removeWhere(
      (typedListener) => typedListener.callback == listener,
    );
    if (_fieldListeners[fieldName]?.isEmpty ?? false) {
      _fieldListeners.remove(fieldName);
    }
  }

  /// Called when a field is updated to notify any registered listeners
  void notifyFieldListeners<T>(String field, T value) {
    final listeners = _fieldListeners[field];
    if (listeners == null) return;

    final fieldValue = state.fields[field]?.value;
    // Verify that the field exists and the value type matches the field's type
    if (fieldValue != null && value.runtimeType != fieldValue.runtimeType) {
      throw ArgumentError(
        'Type mismatch in notifyFieldListeners: Field "$field" expects type '
        '"${fieldValue.runtimeType}" but received "${value.runtimeType}"',
      );
    }

    for (final typedListener in listeners) {
      if (typedListener is! _TypedListener<T>) {
        throw ArgumentError(
          'Listener type mismatch: Field "$field" has listener of type '
          '"${typedListener.runtimeType}" but was notified with type "$T".\n'
          'This might happen if you registered a listener with a different type '
          'than the field\'s actual type.',
        );
      }
      typedListener.call(value);
    }
  }

  /// resets the initial field values
  void resetInitialFieldsValue() {
    _initialFieldValues.clear();
    for (final entry in state.fields.entries) {
      _initialFieldValues[entry.key] = entry.value.value;
    }
  }

  /// Cleans up tracking resources
  @protected
  void disposeTracking() {
    _fieldListeners.clear();
    _initialFieldValues.clear();
  }
}
