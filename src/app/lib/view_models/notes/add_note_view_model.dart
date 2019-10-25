import 'package:app/models/models.dart';
import 'package:app/models/notes/note_item_model.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/tags/edit_tags_view_model.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';
import 'package:uuid/uuid.dart';

class AddOrEditNoteViewModel extends InitializableViewModel<NoteItemModel> {
  AddOrEditNoteViewModel(
    this._notesManager,
    this._tagsManager,
    this._accountManager,
    this._cameraService,
    this._mlVisionService,
    this._navigationService,
    this._dialogService,
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
  final DialogService _dialogService;

  void Function(String text) _onTextRecognized;

  List<TagEntity> tags;
  NoteItemModel note;
  bool isEditing;

  TagEntity _assignedTag;
  TagEntity get assignedTag => _assignedTag;
  set assignedTag(TagEntity value) {
    if (_assignedTag == value) {
      _assignedTag = value;
      return;
    }
    _assignedTag = value;
    notifyListeners('assignedTag');
  }

  void onTextRecognized(void Function(String text) callback) => _onTextRecognized = callback;

  Future<void> onSaveNote() async {
    await _notesManager.addNote(NoteEntity(
      id: Uuid().v1(),
      title: note.title ?? 'No title',
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
      tag: assignedTag,
      lastModified: DateTime.now(),
    ));

    _navigationService.pop();
  }

  Future<void> onSaveEditedNote() async {
    await _notesManager.updateNote(NoteEntity(
      id: note.id,
      title: note.title ?? 'No title',
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
      tag: assignedTag,
      lastModified: DateTime.now(),
    ));

    _navigationService.pop();
  }

  Future<void> onSelectTag() async {
    TagItemModel chosenTag = await _navigationService.push(
      ViewNames.editTagsView,
      parameter: TagTransactionType.choose,
    );

    if (chosenTag != null) {
      assignedTag = TagEntity(
        id: chosenTag.id,
        name: chosenTag.name,
        created: chosenTag.created,
      );
    } else
      assignedTag = assignedTag != null ? assignedTag : null;
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
    final shouldDelete = await _dialogService.confirm('This cannot be undone.', title: 'Delete note?', ok: 'Delete');

    if (shouldDelete) {
      await _notesManager.deleteNote(NoteEntity(id: note.id));
      _navigationService.pop();
    }
  }

  @override
  void initParameter(NoteItemModel parameter) {
    if (parameter != null) {
      note = parameter;
      isEditing = true;
      assignedTag = parameter.tag;
    }
  }
}
