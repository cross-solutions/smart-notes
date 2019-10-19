import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/home/notes_list_view_model.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    this.notesListViewModel,
    AccountManager accountManager,
    this._authManager,
    this._tagsManager,
    this._navigationService,
    this._dialogService,
  ) {
    currentAccount = accountManager.currentAccount;
    editingMode = ListEditingMode.none;
    tags = [];

    _tagsStreamSubscription = _tagsManager.tagsStream.listen(_onTagsAdded);
  }

  final NotesListViewModel notesListViewModel;
  AccountEntity currentAccount;

  final AuthManager _authManager;
  final TagsManager _tagsManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  StreamSubscription _tagsStreamSubscription;

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

  ListEditingMode _editingMode;
  ListEditingMode get editingMode => _editingMode;
  set editingMode(ListEditingMode value) {
    if (_editingMode == value) {
      _editingMode = value;
      return;
    }
    _editingMode = value;
    notifyListeners('editingMode');

    if (_editingMode == ListEditingMode.none) notesListViewModel.notes.forEach((n) => n.isSelected = false);
  }

  @override
  void dispose() {
    _tagsStreamSubscription.cancel();
    super.dispose();
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

  Future<void> onAddNote() => _navigationService.pushModal(ViewNames.addNoteView);

  void _onTagsAdded(List<TagEntity> newTags) {
    final selectedTagModels = tags.where((t) => t.isSelected).toList();
    final newTagModels = newTags.map((t) => TagItemModel(t.id, t.name)).toList();
    selectedTagModels.forEach((t1) => newTagModels.firstWhere((t2) => t2.id == t1.id)..isSelected = true);
    tags = newTagModels;
  }
}
