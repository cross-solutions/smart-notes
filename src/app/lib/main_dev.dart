
import 'package:app/service_locator.dart';
import 'package:app/views/app_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This is the main entry point of our application.
/// Use this method to configure your app for development.
void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  ServiceLocator.configure();
  runApp(ServiceLocator.resolve<AppView>());
}
