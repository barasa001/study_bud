import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/login.dart';

void main() {
  group('LoginPage Widget Test', () {
    testWidgets('UI Rendering Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Verify that the app has the expected UI components.
      expect(find.text('Login'), findsOneWidget);
      expect(find.byKey(Key('email-field')), findsOneWidget);
      expect(find.byKey(Key('password-field')), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(InkWell),
          findsNWidgets(2)); // Google and Apple sign-in buttons
    });

    testWidgets('Login Button Tap Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: LoginPage()));

      // Enter valid email and password
      await tester.enterText(
          find.byKey(Key('email-field')), 'test@example.com');
      await tester.enterText(find.byKey(Key('password-field')), 'password');

      // Tap on the login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the app navigates to the home page after successful login.
      expect(find.text('Chat'), findsOneWidget);
    });
  });
}
