import 'package:bond_core/bond_core.dart';
import 'package:bond_form/validator_localizations.dart';
import 'package:example/features/auth/presentations/login_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setUpAll(() async {
    sl.registerSingleton<ValidatorLocalizations>(
      await ValidatorLocalizations.load(const Locale('en')),
    );
  });

  testWidgets(
    'Should display error messages for email and password when the form is invalid and the login button is tapped',
    (WidgetTester tester) async {
      // Initialize the app if needed (e.g., mock dependencies, set up localization, etc.)

      // Build the LoginForm widget wrapped with required parent widgets
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: Scaffold(body: LoginPage())),
        ),
      );

      // Check that error messages are not displayed initially
      expect(
        find.text(sl<ValidatorLocalizations>().emailValidationMessage('Email')),
        findsNothing,
      );
      expect(
        find.text(
          sl<ValidatorLocalizations>().minLengthValidationMessage(
            'Password',
            6,
          ),
        ),
        findsNothing,
      );

      // Simulate user input with invalid email and password
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'invalid-email',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        '123',
      );

      // Simulate tapping the login button
      await tester.tap(find.widgetWithText(MaterialButton, 'Login'));
      await tester.pumpAndSettle(); // Complete all animations and builds

      // Verify that error messages appear as expected
      expect(
        find.text(sl<ValidatorLocalizations>().emailValidationMessage('Email')),
        findsOneWidget,
      );
      expect(
        find.text(
          sl<ValidatorLocalizations>().minLengthValidationMessage(
            'Password',
            6,
          ),
        ),
        findsOneWidget,
      );
    },
  );
}
