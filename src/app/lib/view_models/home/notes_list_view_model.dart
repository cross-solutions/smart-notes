import 'package:app/models/models.dart';
import 'package:app/view_models/base/base_view_model.dart';
import 'package:app_business/managers.dart';
import 'package:app_business/entities.dart';

class NotesListViewModel extends BaseViewModel {
  NotesListViewModel(this._notesManager, this._tagManager) {
    notes = [];
    _notesManager.notesStream.listen(_onNotesAdded);
  }

  final NotesManager _notesManager;
  final TagsManager _tagManager;

  List<TagItemModel> tags;

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

  void _onNotesAdded(List<NoteEntity> newNotes) async {
    final mappedList = newNotes.map((n) async {
      final tag = await _tagManager.getTag(n.tagId);
      final tagModel = TagItemModel(tag.id, tag.name);

      return NoteItemModel(id: n.id, tag: tagModel);
    }).toList();

    notes = await Future.wait(mappedList);
  }
}
