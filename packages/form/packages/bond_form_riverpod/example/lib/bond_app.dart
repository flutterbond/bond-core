import 'package:example/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

import 'app/routes.dart';

class BondApp extends StatelessWidget {
  const BondApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routes,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      locale: const Locale('en'),
      supportedLocales: const [Locale('en')],
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.system,
    );
  }
}
