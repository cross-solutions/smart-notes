import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/view_models/base/base_view_model.dart';
import 'package:app_business/managers.dart';
import 'package:app_business/entities.dart';

class NotesListViewModel extends BaseViewModel {
  NotesListViewModel(this._notesManager, this._tagManager) {
    notes = [
      // NoteItemModel(
      //   title: 'Moving day',
      //   content:
      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      // ),
      // NoteItemModel(
      //   title: 'Saved Playlist Concert',
      //   content:
      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      // ),
      // NoteItemModel(
      //   title: 'Burger Recipe',
      //   content:
      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      // ),
      // NoteItemModel(
      //   title: 'Museum Visit',
      //   content:
      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      // ),
      // NoteItemModel(
      //   title: 'System Analysis and Design',
      //   content:
      //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      // ),
    ];
    selectedNotesCount = 0;
    _notesStreamSubscription = _notesManager.notesStream.listen(_onNotesAdded);
  }

  final NotesManager _notesManager;
  final TagsManager _tagManager;
  StreamSubscription _notesStreamSubscription;

  List<TagItemModel> tags;

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
    _notesStreamSubscription.cancel();
    super.dispose();
  }

  void selectAllNotes() {
    notes.forEach((n) => n.isSelected = true);
    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  void selectNote(NoteItemModel note) {
    note.isSelected = true;
    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  void unselectNote(NoteItemModel note) {
    note.isSelected = false;
    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }

  Future<void> deleteNotes() async {
    final notesToBeDeleted = notes.where((n) => n.isSelected);
    if (notesToBeDeleted.isNotEmpty) {
      for (final note in notesToBeDeleted) {
        await _notesManager.deleteNote(NoteEntity(id: note.id));
      }
    }
  }

  void _onNotesAdded(List<NoteEntity> newNotes) async {
    final mappedList = newNotes.map((n) async {
      if (n.tagId != null) {
        final tag = await _tagManager.getTag(n.tagId);
        final tagModel = TagItemModel(tag.id, tag.name);
        return NoteItemModel(
          id: n.id,
          tag: tagModel,
          title: n.title,
          content: n.content,
        );
      } else
        return NoteItemModel(
          id: n.id,
          title: n.title,
          content: n.content,
        );
    }).toList();

    notes = await Future.wait(mappedList);
    selectedNotesCount = notes.where((n) => n.isSelected).length;
  }
}
