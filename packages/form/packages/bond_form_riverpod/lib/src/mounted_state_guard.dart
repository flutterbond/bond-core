import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

/// Keeps a form notifier usable around the disposal of its provider.
///
/// Riverpod 3 throws an `UnmountedRefException` when `state` is read or
/// written after the provider was disposed, and asserts when `state` is read
/// inside a `ref.onDispose` callback. The bond_form controllers do both: an
/// async `submit()` writes the result after `await onSubmit()`, which can
/// complete after the page was closed, and `dispose()` reads the fields to
/// release them.
///
/// This mixin remembers the latest state so that it can still be read in
/// those two situations, and ignores writes once `ref.mounted` is false.
@internal
mixin MountedStateGuard<StateT extends Object> on Notifier<StateT> {
  StateT? _lastState;
  var _disposing = false;

  @override
  StateT get state {
    final lastState = _lastState;
    if (lastState != null && (_disposing || !ref.mounted)) return lastState;
    return _lastState = super.state;
  }

  @override
  set state(StateT newState) {
    if (!ref.mounted) return;
    super.state = newState;
    _lastState = newState;
  }

  /// Records [initialState] as the latest state and returns it.
  ///
  /// Wraps the value returned by `build`, so that the state is known even if
  /// the provider is disposed before anything reads it.
  @protected
  StateT trackInitialState(StateT initialState) => _lastState = initialState;

  /// Registers [callback] with `ref.onDispose`.
  ///
  /// While [callback] runs, [state] returns the latest state instead of going
  /// through `ref`, which Riverpod does not allow inside life-cycle callbacks.
  @protected
  void onDisposeWithState(void Function() callback) {
    ref.onDispose(() {
      _disposing = true;
      try {
        callback();
      } finally {
        _disposing = false;
      }
    });
  }
}
