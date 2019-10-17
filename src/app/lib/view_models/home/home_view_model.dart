import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    AccountManager accountManager,
    this._authManager,
    this._navigationService,
    this._dialogService,
  ) {
    currentAccount = accountManager.currentAccount;
    tags = [
      TagItemModel('01', 'Design'),
      TagItemModel('02', 'Work'),
      TagItemModel('03', 'School'),
      TagItemModel('04', 'Home'),
      TagItemModel('05', 'Others'),
    ];
    selectedTags = [];
  }

  final AuthManager _authManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  AccountEntity currentAccount;
  List<TagItemModel> tags;
  List<TagItemModel> selectedTags = [];

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

  void onSelectedTagsChanged(List<TagItemModel> newTags) {
    selectedTags = newTags;
    notifyListeners();
  }

  Future<void> addTag() async {
    tags.add(TagItemModel('00', 'Other Item ${tags.length}'));
    notifyListeners();
  }
}
