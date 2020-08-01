import 'package:smart_notes/services/services.dart';
import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes_business/managers.dart';
import 'package:smart_notes_common/constants.dart';
import 'package:smart_notes_common/exceptions.dart';
import 'package:smart_notes_util/app_util.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(
      this._authManager, this._navigationService, this._dialogService);

  final AuthManager _authManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  Future<void> signInToGoogle() async {
    try {
      await _authManager.signIn();
      await _navigationService.pushReplacement(ViewNames.homeView);
    } on AuthException catch (aex) {
      debugError('Failed to sign-in: ${aex.message}');
    } on OperationCanceledException {
      debugInfo('Sign-in cancelled');
    } on Error catch (e) {
      debugError('Failed to sign-in: $e');
      await _dialogService.alert('We are having trouble signing you in.',
          title: 'Login failed');
    }
  }
}
