import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/homepagechat.dart';

void main() {
  group('HomePageChat Widget Test', () {
    testWidgets('UI Rendering Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePageChat()));

      // Verify that the app has the expected UI components.
      expect(find.text('Chat'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(StreamBuilder), findsOneWidget);
    });

    testWidgets('Chat Button Tap Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: HomePageChat()));

      // Tap on the chat button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the app navigates to the chat page.
      expect(find.text('Chat with'), findsOneWidget);
    });
  });
}
