// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app/keys/widget_keys.dart';
import 'package:app/service_locator.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/test_root_widget.dart';

void main() {
  group('MainView', () {
    Widget widget;

    setUp(() {
      widget = TestRootWidget(child: MainView(ServiceLocator.resolve<MainViewModel>()));
    });

    setUpAll(() {
      ServiceLocator.configure();
    });

    testWidgets('counter increments by one', (WidgetTester tester) async {
      // // Arrange
      final incrementButton = find.byKey(MainViewKeys.incrementButton);

      // // Act
      await tester.pumpWidget(widget);
      await tester.tap(incrementButton);
      await tester.pumpAndSettle(); // Trigger an update

      // // Expect that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('counter decrements by one', (WidgetTester tester) async {
      // Arrange
      final decrementButton = find.byKey(MainViewKeys.decrementButton);

      // Act
      await tester.pumpWidget(widget);
      await tester.tap(decrementButton);
      await tester.pumpAndSettle(); // Trigger an update

      // Expect that our counter has decremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('navigates to SecondView', (WidgetTester tester) async {
      // Arrange
      final mainView = find.byKey(MainViewKeys.view);
      final secondView = find.byKey(SecondViewKeys.view);
      final goToSecondViewButton = find.byKey(MainViewKeys.goToSecondView);

      // Act
      await tester.pumpWidget(widget);
      await tester.tap(goToSecondViewButton);
      await tester.pumpAndSettle(); // Trigger an update

      // Expect that MainView is not found, and SecondView is shown
      expect(mainView, findsNothing);
      expect(secondView, findsOneWidget);
    });
  });
}
