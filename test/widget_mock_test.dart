// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:osaka20211027/logic.dart';

import 'package:osaka20211027/main.dart';

class MockLogic extends Mock implements Logic {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    MockLogic mock = MockLogic();
    when(() => mock.counter).thenReturn(0);
    verifyNever(() => mock.increase());

    GetIt.I.registerSingleton<Logic>(mock);
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    verifyNever(() => mock.increase());

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    verify(() => mock.increase()).called(2);
    verifyNever(() => mock.increase());

    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
