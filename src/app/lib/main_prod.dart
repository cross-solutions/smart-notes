import 'package:app/service_locator.dart';
import 'package:app/views/views.dart';
import 'package:flutter/material.dart';

/// This is the main entry point of our application.
/// Use this method to configure your app for production.
void main() {
  ServiceLocator.configure();
  runApp(ServiceLocator.resolve<AppView>());
}
