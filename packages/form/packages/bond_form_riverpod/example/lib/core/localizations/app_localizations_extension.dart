import 'package:material_ui/material_ui.dart';
import 'package:example/l10n/app_localizations.dart';

extension Localizations on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
