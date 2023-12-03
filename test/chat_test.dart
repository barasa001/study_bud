import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_bud/chat.dart';

void main() {
  group('ChatPage Tests', () {
    testWidgets('Renders ChatPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage()));
      expect(find.text('Chat'), findsOneWidget);
    });

    testWidgets('Selects User and Navigates to ChatScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage()));
      await tester.tap(find.text('Seth Barasa'));
      await tester.pump();
      expect(find.text('Chatting with Seth Barasa'), findsOneWidget);
    });
  });

  group('ChatScreen Tests', () {
    testWidgets('Renders ChatScreen', (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: ChatScreen(username: 'TestUser')));
      expect(find.text('Chat with TestUser'), findsOneWidget);
    });
  });
}
