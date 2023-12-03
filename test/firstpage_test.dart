import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/firstpage.dart';

void main() {
  group('FirstPage Widget Test', () {
    testWidgets('UI Rendering Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: StudyBudPage()));

      // Verify that the app has the expected UI components.
      expect(find.text('Study Bud'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Signup Button Tap Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: StudyBudPage()));

      // Tap on the signup button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the app navigates to the signup page.
      expect(find.text('Signup'), findsOneWidget);
    });

    testWidgets('Login Button Tap Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: StudyBudPage()));

      // Tap on the login button
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Verify that the app navigates to the login page.
      expect(find.text('Login'), findsOneWidget);
    });
  });
}
