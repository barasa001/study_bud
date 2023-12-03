import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/signup.dart';

void main() {
  group('SignupPage Widget Test', () {
    testWidgets('UI Rendering Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Verify that the app has the expected UI components.
      expect(find.text('Signup'), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Signup Button Tap Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Tap on the signup button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the app navigates to the login page.
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
