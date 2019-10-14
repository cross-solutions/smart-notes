import 'dart:io';

import 'package:test/test.dart';
import 'package:app_constants/app_constants.dart';
import 'package:flutter_driver/flutter_driver.dart';

void main() {
  FlutterDriver driver;
  setUpAll(() async {
    await Directory('screenshots').create();
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    await driver.close();
  });

  Future<void> screenshot(FlutterDriver driver, String fileName) async {
    print('Taking screenshot...');
    final bytes = await driver.screenshot();
    final file = File('screenshots/$fileName.png');
    await file.writeAsBytes(bytes);
  }

  test('Check flutter driver health', () async {
    final health = await driver.checkHealth();
    print('Driver health: ${health.status}');
  });

  group('MainView', () {
    test('increment counter', () async {
      // Arrange
      final incrementButton = find.byValueKey(MainViewKeyValues.incrementButton);

      // Wait for increment button to show and tap it 5 times.
      await driver.waitFor(incrementButton);
      await driver.tap(incrementButton);
      await driver.tap(incrementButton);
      await driver.tap(incrementButton);
      await driver.tap(incrementButton);
      await driver.tap(incrementButton);

      await screenshot(driver, 'main_view_counter_incremented');
    });

    test('decrement counter', () async {
      // Arrange
      final decrementButton = find.byValueKey(MainViewKeyValues.decrementButton);

      // Wait for decrement button to show and tap it 5 times.
      await driver.waitFor(decrementButton);
      await driver.tap(decrementButton);
      await driver.tap(decrementButton);
      await driver.tap(decrementButton);
      await driver.tap(decrementButton);
      await driver.tap(decrementButton);

      await screenshot(driver, 'main_view_counter_decremented');
    });

    test('navigate to SecondView', () async {
      // Arrange
      final mainView = find.byValueKey(MainViewKeyValues.view);
      final secondView = find.byValueKey(SecondViewKeyValues.view);
      final goToSecondViewButton = find.byValueKey(MainViewKeyValues.goToSecondView);

      // Wait for button to show and tap it.
      await driver.waitFor(goToSecondViewButton);
      await driver.tap(goToSecondViewButton);

      // Wait for MainView to disappear.
      await driver.waitForAbsent(mainView);

      // Wait for SecondView to appear.
      await driver.waitFor(secondView);

      await screenshot(driver, 'second_view_appeared');
    });
  });
}
