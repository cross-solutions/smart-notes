import 'dart:async';

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
    this._tagsManager,
    this._notesManager,
    this._navigationService,
    this._dialogService,
  ) {
    currentAccount = accountManager.currentAccount;
    tags = [];
    notes = [];
    editingMode = ListEditingMode.none;
    selectedNotesCount = 0;

    _tagsStreamSubscription = _tagsManager.getTagsStream(currentAccount.id).listen(_onTagsChanged);
    _notesStreamSubscription = _notesManager.getNotesStream(currentAccount.id).listen(_onNotesChanged);
  }

  AccountEntity currentAccount;

  final AuthManager _authManager;
  final TagsManager _tagsManager;
  final NotesManager _notesManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;
  StreamSubscription _tagsStreamSubscription;
  StreamSubscription _notesStreamSubscription;

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
  }

  int _selectedNotesCount;
  int get selectedNotesCount => _selectedNotesCount;
  set selectedNotesCount(int value) {
    if (_selectedNotesCount == value) {
      _selectedNotesCount = value;
      return;
    }
    _selectedNotesCount = value;
    notifyListeners('selectedNotesCount');
  }

  List<NoteItemModel> _notes;
  List<NoteItemModel> get notes => _notes;
  set notes(List<NoteItemModel> value) {
    if (_notes == value) {
      _notes = value;
      return;
    }
    _notes = value;
    notifyListeners('notes');
  }

  @override
  void dispose() {
    _tagsStreamSubscription.cancel();
    _notesStreamSubscription.cancel();
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

  void onToggleEditingMode() {
    switch (editingMode) {
      case ListEditingMode.none:
        editingMode = ListEditingMode.delete;
        break;

      case ListEditingMode.delete:
        editingMode = ListEditingMode.none;
        notes.forEach((n) => n.isSelected = false);
        break;
    }
  }

  void onToggleSelectAllNotes() {
    final allNotesSelected = notes.every((n) => n.isSelected);

    if (allNotesSelected)
      notes.forEach((n) => n.isSelected = false);
    else
      notes.forEach((n) => n.isSelected = true);

    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  void onToggleNoteSelection(NoteItemModel note) {
    note.isSelected = !note.isSelected;
    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  Future<void> onViewNote(NoteItemModel note) => _navigationService.pushModal(ViewNames.addNoteView, parameter: note);

  void Function() get onDeleteSelectedNotes {
    if (selectedNotesCount == 0)
      return null;
    else {
      return () async {
        final notesToBeDeleted = notes.where((n) => n.isSelected);
        for (final note in notesToBeDeleted) {
          await _notesManager.deleteNote(NoteEntity(id: note.id));
        }

        onToggleEditingMode();
      };
    }
  }

  void _onNotesChanged(List<NoteEntity> newNotes) {
    notes = newNotes.map((n) {
      return NoteItemModel(
        id: n.id,
        tagId: n.tagId,
        title: n.title,
        content: n.content,
      );
    }).toList();

    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  void _onTagsChanged(List<TagEntity> newTags) {
    final selectedTagModels = tags.where((t) => t.isSelected).toList();
    final newTagModels = newTags.map((t) => TagItemModel(t.id, t.name)).toList();
    selectedTagModels.forEach((t1) => newTagModels.firstWhere((t2) => t2.id == t1.id)..isSelected = true);
    tags = newTagModels;
  }
}
