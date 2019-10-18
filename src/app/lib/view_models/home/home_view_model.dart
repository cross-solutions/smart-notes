import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    AccountManager accountManager,
    this._authManager,
    this._tagsManager,
    this._navigationService,
    this._dialogService,
  ) {
    currentAccount = accountManager.currentAccount;
    tags = [];

    _tagsManager.watchTags().listen(_onTagsAdded);
  }

  final AuthManager _authManager;
  final TagsManager _tagsManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  AccountEntity currentAccount;

  List<TagItemModel> _tags;
  List<TagItemModel> get tags => _tags;
  set tags(List<TagItemModel> value) {
    if (_tags == value) {
      _tags = value;
      return;
    }
    _tags = value;
    notifyListeners('tags');
  }

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

  Future<void> addTag() async {
    _tagsManager.addTag(TagEntity(id: Uuid().v1(), name: 'Tag ${tags.length + 1}'));
  }

  Future<void> deleteTag() async {
    for (final tag in tags) {
      await _tagsManager.deleteTag(TagEntity(id: tag.id, name: tag.name));
    }
  }

  void _onTagsAdded(List<TagEntity> newTags) => tags = newTags.map((t) => TagItemModel(t.id, t.name)).toList();
}
