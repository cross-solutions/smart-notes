import 'package:flutter/foundation.dart';

abstract class AnalyticsService {
  Future<void> start();

  Future<void> trackEvent(String eventName, [Map<String, String> properties]);
}

class AnalyticsServiceImpl implements AnalyticsService {
  @override
  Future<void> start() async {
    if (kReleaseMode) {
      switch (defaultTargetPlatform) {
        default:
          return Future.value();
      }
    }
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, String> properties]) =>
      Future.value();
}
