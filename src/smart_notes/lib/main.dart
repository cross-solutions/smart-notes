import 'package:smart_notes/service_locator.dart';
import 'package:smart_notes/views/app_view.dart';
import 'package:flutter/material.dart';

/// This is the main entry point of our application.
/// Use this method to configure your app for development.
void main() {
  ServiceLocator.configure();
  runApp(ServiceLocator.resolve<AppView>());
}
