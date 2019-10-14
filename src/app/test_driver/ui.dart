import 'package:flutter_driver/driver_extension.dart';
import 'package:app/main_dev.dart' as app;

// Main entry point for Flutter Driver.
// Run using command `flutter driver app.dart`
void main() {
  enableFlutterDriverExtension();
  app.main();
}
