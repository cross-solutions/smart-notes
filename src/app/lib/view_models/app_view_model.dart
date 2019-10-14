import 'package:app/services/navigation/navigation_service.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_constants/app_constants.dart';
import 'package:app_util/app_util.dart';

class AppViewModel extends BaseViewModel {
  AppViewModel(this.analyticsService, this.navigationService) {
    _onInitialize();
  }

  final AnalyticsService analyticsService;
  final NavigationService navigationService;

  Future<void> _onInitialize() async {
    // Represents a initialization task
    // Shows [SplashWidget] while this is running.
    await analyticsService.start();
    await Future.delayed(Duration(seconds: 1)); // Other tasks

    await navigationService.pushReplacement(ViewNames.mainView);
  }
}
