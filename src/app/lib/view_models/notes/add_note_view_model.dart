import 'package:app/models/notes/note_item_model.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:uuid/uuid.dart';

class AddOrEditNoteViewModel extends InitializableViewModel<NoteItemModel> {
  AddOrEditNoteViewModel(
    this._notesManager,
    this._tagsManager,
    this._accountManager,
    this._cameraService,
    this._mlVisionService,
    this._navigationService,
  ) {
    _tagsManager.tags.then((tags) {
      this.tags = tags;
    });
    note = NoteItemModel();
    isEditing = false;
  }

  final NotesManager _notesManager;
  final TagsManager _tagsManager;
  final AccountManager _accountManager;
  final CameraService _cameraService;
  final MLVisionService _mlVisionService;
  final NavigationService _navigationService;

  void Function(String text) _onTextRecognized;

  List<TagEntity> tags;
  NoteItemModel note;

  bool isEditing;

  void onTextRecognized(void Function(String text) callback) => _onTextRecognized = callback;

  Future<void> onSaveNote() async {
    await _notesManager.addNote(NoteEntity(
      id: Uuid().v1(),
      title: note.title ?? 'Note from ${DateTime.now().toString()}',
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
    ));

    _navigationService.pop();
  }

  Future<void> onSaveEditedNote() async {
    await _notesManager.updateNote(NoteEntity(
      id: note.id,
      title: note.title ?? 'Note from ${DateTime.now().toString()}',
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
    ));

    _navigationService.pop();
  }

  Future<void> onStartTextRecognitionFromCamera() async {
    final imageFile = await _cameraService.takePhoto();

    if (imageFile != null) {
      final recognitionResult = await _mlVisionService.extractTextFromImageFile(imageFile);

      if (recognitionResult.status == MLVisionResultStatus.completed && _onTextRecognized != null) {
        _onTextRecognized(recognitionResult.text);
      }

      await imageFile.delete();
    }
  }

  Future<void> deleteNoteToEdit() async {
    await _notesManager.deleteNote(NoteEntity(id: note.id));
    _navigationService.pop();
  }

  @override
  void initParameter(NoteItemModel parameter) {
    if (parameter != null) {
      note = parameter;
      isEditing = true;
    }
  }
}
