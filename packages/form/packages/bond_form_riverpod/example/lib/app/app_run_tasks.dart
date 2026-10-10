import 'dart:developer';

import 'package:bond_core/bond_core.dart';
import 'package:material_ui/material_ui.dart';

import 'package:stack_trace/stack_trace.dart' as stack_trace;

class RunAppTasks extends RunTasks {
  RunAppTasks() : super();

  @override
  Future<void> beforeRun(WidgetsBinding widgetsBinding) async {
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is stack_trace.Trace) return stack.vmTrace;
      if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
      return stack;
    };
  }

  @override
  Future<void> afterRun() async {}

  @override
  void onError(Object error, StackTrace stack) {
    log('Error: $error', stackTrace: stack);
  }
}
