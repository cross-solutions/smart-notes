import 'package:flutter/foundation.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:smart_notes_common/constants.dart';

abstract class AnalyticsService {
  Future<void> start();

  Future<void> trackEvent(String eventName, [Map<String, String> properties]);
}

class AnalyticsServiceImpl implements AnalyticsService {
  @override
  Future<void> start() async {
    if (kReleaseMode) {
      await AppCenter.startAsync(
          appSecretAndroid: AppCenterIds.androidId,
          appSecretIOS: AppCenterIds.iOSId,
          enableAnalytics: true,
          enableCrashes: true,
          enableDistribute: false,
          disableAutomaticCheckForUpdate: true);
    }
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, String> properties]) =>
      AppCenter.trackEventAsync(eventName, properties);
}
