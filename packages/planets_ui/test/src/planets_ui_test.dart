// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planets_ui/src/planets_button.dart';

void main() {
  group('PlanetsButton', () {
    testWidgets('renders correctly with the provided text', (WidgetTester tester) async {
      const buttonText = 'Click Me';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlanetsButton(
              text: buttonText,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('triggers the callback when pressed', (WidgetTester tester) async {
      var pressed = false;

      // Build the widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PlanetsButton(
              text: 'Press me',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(ElevatedButton));

      // Rebuild the widget after the state has changed
      await tester.pump();

      // Verify that the onPressed callback was triggered
      expect(pressed, isTrue);
    });
  });
}
