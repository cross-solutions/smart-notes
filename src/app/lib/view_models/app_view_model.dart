import 'package:app/services/navigation/navigation_service.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/exceptions.dart';
import 'package:app_common/constants.dart';
import 'package:app_util/app_util.dart';

class AppViewModel extends BaseViewModel {
  AppViewModel(
    this._authManager,
    this._analyticsService,
    this._navigationService,
  ) {
    _onInitialize();
  }

  final AuthManager _authManager;
  final AnalyticsService _analyticsService;
  final NavigationService _navigationService;

  Future<void> _onInitialize() async {
    try {
      await Future.wait([
        _analyticsService.start(),
        _authManager.ensureUserSignedIn(),
        Future.delayed(Duration(seconds: 1)),
      ]);

      await _navigationService.pushReplacement(ViewNames.homeView);
    } on AuthException catch (aex) {
      debugError(aex.message);
      await _navigationService.pushReplacement(ViewNames.loginView);
    }
  }
}
