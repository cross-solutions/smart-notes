import 'package:app/services/navigation/navigation_service.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/app_business.dart';
import 'package:app_common/app_common.dart';
import 'package:app_util/app_util.dart';

class AppViewModel extends BaseViewModel {
  AppViewModel(this._authManager, this._analyticsService, this._navigationService) {
    _onInitialize();
  }

  final AuthManager _authManager;
  final AnalyticsService _analyticsService;
  final NavigationService _navigationService;

  Future<void> _onInitialize() async {
    await _analyticsService.start();
    await Future.delayed(Duration(seconds: 1));

    try {
      await _authManager.ensureUserAlreadySignedIn();
      await _navigationService.pushReplacement(ViewNames.homeView);
    } on AuthException catch (aex) {
      debugError(aex.message);
      await _navigationService.pushReplacement(ViewNames.loginView);
    }
  }
}
