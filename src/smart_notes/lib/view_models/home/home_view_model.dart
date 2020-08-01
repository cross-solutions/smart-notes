import 'dart:async';

import 'package:smart_notes/models/models.dart';
import 'package:smart_notes/services/services.dart';
import 'package:smart_notes/view_models/view_models.dart';
import 'package:smart_notes_business/entities.dart';
import 'package:smart_notes_business/managers.dart';
import 'package:smart_notes_common/constants.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    AccountManager accountManager,
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

    _tagsStreamSubscription =
        _tagsManager.getTagsStream(currentAccount.id).listen(_onTagsChanged);
    _notesStreamSubscription =
        _notesManager.getNotesStream(currentAccount.id).listen(_onNotesChanged);
  }

  final TagsManager _tagsManager;
  final NotesManager _notesManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  StreamSubscription _tagsStreamSubscription;
  StreamSubscription _notesStreamSubscription;

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

  TagItemModel _selectedTag;
  TagItemModel get selectedTag => _selectedTag;
  set selectedTag(TagItemModel value) {
    if (_selectedTag == value) {
      _selectedTag = value;
      return;
    }
    _selectedTag = value;
    _onFilterTags(_selectedTag);
    notifyListeners('selectedTag');
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
  }

  Future<void> onShowSettings() =>
      _navigationService.push(ViewNames.settingsView);

  Future<void> onAddNote() => _navigationService.pushModal(ViewNames.noteView);

  void onEditTags() => _navigationService.push(ViewNames.tagsView);

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

  void onToggleTagSelection(TagItemModel tag) {
    if (tag == selectedTag) {
      selectedTag = null;
    } else {
      tag.isSelected = true;
      selectedTag?.isSelected = false;
      selectedTag = tag;
    }
  }

  Future<void> onViewNote(NoteItemModel note) =>
      _navigationService.pushModal(ViewNames.noteView, parameter: note);

  void Function() get onDeleteSelectedNotes {
    if (selectedNotesCount == 0)
      return null;
    else {
      return () async {
        final shouldDelete = await _dialogService.confirm(
            'This cannot be undone.',
            title: 'Delete note/s?',
            ok: 'Delete');

        if (shouldDelete == true) {
          final notesToBeDeleted = notes.where((n) => n.isSelected);
          for (final note in notesToBeDeleted) {
            await _notesManager.deleteNote(NoteEntity(id: note.id));
          }

          onToggleEditingMode();
        }
      };
    }
  }

  Future<bool> onBackPressed() async {
    final isDeleting = editingMode == ListEditingMode.delete;
    if (isDeleting) onToggleEditingMode();
    return !isDeleting;
  }

  void _onFilterTags(TagItemModel tag) {
    if (tag != null) {
      _notesStreamSubscription.cancel();
      _notesStreamSubscription = _notesManager
          .getNotesWithTagStream(currentAccount.id, tag.id)
          .listen(_onNotesChanged);
    } else {
      _notesStreamSubscription.cancel();
      _notesStreamSubscription = _notesManager
          .getNotesStream(currentAccount.id)
          .listen(_onNotesChanged);
    }
  }

  void _onNotesChanged(List<NoteEntity> newNotes) {
    notes = newNotes.map((n) {
      return NoteItemModel(
        id: n.id,
        title: n.title,
        content: n.content,
        created: n.created,
        lastModified: n.lastModified,
        tag: n.tag,
      );
    }).toList()
      ..sort((n1, n2) {
        if (n2.lastModified == null) {
          return n2.created.compareTo(n1.lastModified ?? n1.created);
        } else {
          return n2.lastModified.compareTo(n1.lastModified ?? n1.created);
        }
      });

    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  void _onTagsChanged(List<TagEntity> newTags) {
    final newTagModels = newTags
        .map((t) => TagItemModel(t.id, t.name, t.created, t.lastModified))
        .toList();
    final selectedTagExists =
        newTagModels.contains((t) => t.id == selectedTag?.id);

    if (selectedTagExists) {
      newTagModels.firstWhere((t) => t.id == selectedTag.id).isSelected = true;
    } else
      selectedTag = null;

    tags = newTagModels;
  }
}
