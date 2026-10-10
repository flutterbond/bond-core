import 'dart:async';
import 'dart:developer';

import 'package:bond_core/src/injection.dart';
import 'package:flutter/widgets.dart';

/// Runs the main Flutter application with additional pre and post tasks.
///
/// The [app] provides the main widget for the Flutter application.
/// [tasks] allows executing actions before and after the app is run.
/// [providers] is a list of [ServiceProvider]s used to register services and configurations
void run(
  Widget Function() app, {
  required RunTasks tasks,
  required List<ServiceProvider> providers,
}) {
  runZonedGuarded<Future<void>>(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await init(providers);

    await tasks.beforeRun(widgetsBinding);

    runApp(app());

    await tasks.afterRun();
  }, tasks.onError);
}

/// Represents a set of tasks to run before and after the main Flutter application starts.
class RunTasks {
  /// Executed before the Flutter app starts. By default, this does nothing.
  /// Can be overridden to perform specific tasks before app initialization.
  Future<void> beforeRun(WidgetsBinding widgetsBinding) async {}

  /// Executed after the Flutter app starts. By default, this does nothing.
  /// Can be overridden to perform tasks after the app is up and running.
  Future<void> afterRun() async {}

  /// Handles any errors that occur during the app run lifetime.
  /// By default, it logs the error and its stack trace using the [log] method.
  void onError(Object error, StackTrace stack) {
    log('Error: $error', stackTrace: stack);
  }
}
