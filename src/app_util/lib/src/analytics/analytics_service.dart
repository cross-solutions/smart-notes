import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:flutter/foundation.dart';
import 'package:app_common/app_common.dart';

abstract class AnalyticsService {
  Future<void> start();

  Future<void> trackEvent(String eventName, [Map<String, String> properties]);
}

class AnalyticsServiceImpl implements AnalyticsService {
  @override
  Future<void> start() async {
    if (kReleaseMode) {
      String appSecret;

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          appSecret = AppCenterIds.androidId;
          break;
        case TargetPlatform.fuchsia:
          appSecret = AppCenterIds.iOSId;
          break;

        default:
          return;
      }

      await AppCenter.start(appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
    }
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, String> properties]) =>
      AppCenterAnalytics.trackEvent(eventName, properties);
}
