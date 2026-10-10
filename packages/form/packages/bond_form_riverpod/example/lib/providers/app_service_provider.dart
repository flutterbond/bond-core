import 'dart:ui';

import 'package:bond_form/validator_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:bond_core/bond_core.dart';

class AppServiceProvider extends ServiceProvider {
  @override
  Future<void> register(GetIt it) async {
    it.registerSingletonAsync(
      () => ValidatorLocalizations.load(const Locale('en')),
    );
  }
}
