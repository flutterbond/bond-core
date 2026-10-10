import 'package:bond_core/bond_core.dart';
import 'package:bond_form/validator_localizations.dart';
import 'package:example/bond_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  setUpAll(() async {
    sl.registerSingleton<ValidatorLocalizations>(
      await ValidatorLocalizations.load(const Locale('en')),
    );
  });

  testWidgets(
    'Should validate the current step and keep the next step while typing',
    (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: BondApp()));
      await tester.pumpAndSettle();

      int currentStep() =>
          tester.widget<Stepper>(find.byType(Stepper)).currentStep;

      // An empty step stays on screen with its errors.
      await tester.tap(find.text('Continue').first);
      await tester.pumpAndSettle();
      expect(currentStep(), 0);
      expect(
        find.text(
          sl<ValidatorLocalizations>().requiredValidationMessage('Name'),
        ),
        findsOneWidget,
      );

      await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Bond');
      await tester.enterText(
        find.widgetWithText(TextField, 'Email'),
        'bond@example.com',
      );
      await tester.tap(find.text('Continue').first);
      await tester.pumpAndSettle();

      expect(currentStep(), 1);
      await tester.enterText(
        find.widgetWithText(TextField, 'Vehicle Make'),
        'Toyota',
      );
      await tester.pumpAndSettle();
      expect(currentStep(), 1);
    },
  );
}
