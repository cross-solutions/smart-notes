import 'dart:io';

import 'package:test/test.dart';
import 'package:flutter_driver/flutter_driver.dart';

//ignore_for_file: unused_element

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
}
