import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_util/app_util.dart';
import 'package:uuid/uuid.dart';

class AddNoteViewModel extends BaseViewModel {
  AddNoteViewModel(
    this._notesManager,
    this._tagsManager,
    this._navigationService,
    this._dialogService,
  ) {
    _tagsManager.tags.then((tags) {
      this.tags = tags;
    });
  }

  final NotesManager _notesManager;
  final TagsManager _tagsManager;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  List<TagEntity> tags;

  Future<void> onCreateNote(String title, String content) async {
    try {
      await _notesManager.addNote(NoteEntity(id: Uuid().v1(), title: title, content: content));
      _navigationService.pop();
    } on Error catch (e) {
      debugError(e.toString());
      await _dialogService.alert('Sorry, we could not create your note.', title: 'Failed to create note');
    }
  }
}
