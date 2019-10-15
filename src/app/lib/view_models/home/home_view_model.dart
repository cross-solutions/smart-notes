import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/app_business.dart';
import 'package:app_common/app_common.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    AccountManager accountManager,
    this._authManager,
    this._navigationService,
    this._dialogService,
  ) {
    currentAccount = accountManager.currentAccount;
  }

  final AuthManager _authManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  AccountEntity currentAccount;

  Future<void> signOut() async {
    final shouldLogout = await _dialogService.confirm(
      'Are you sure you want to logout?',
      title: 'Logout account',
      ok: 'Logout',
    );

    if (shouldLogout == true) {
      await _authManager.signOut();
      await _navigationService.pushReplacement(ViewNames.loginView);
    }
  }
}
