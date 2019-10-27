import 'package:app/models/models.dart';
import 'package:app/models/notes/note_item_model.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_common/constants.dart';
import 'package:uuid/uuid.dart';

class NoteViewModel extends InitializableViewModel<NoteItemModel> {
  NoteViewModel(
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
      title: note.title?.isEmpty ?? true == true ? 'No title' : note.title,
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
      tag: assignedTag,
      created: DateTime.now(),
    ));

    _navigationService.pop();
  }

  Future<void> onSaveEditedNote() async {
    await _notesManager.updateNote(NoteEntity(
      id: note.id,
      title: note.title?.isEmpty ?? true == true ? 'No title' : note.title,
      content: note.content,
      ownedBy: _accountManager.currentAccount.id,
      tag: assignedTag,
      created: note.created,
      lastModified: DateTime.now(),
    ));

    _navigationService.pop();
  }

  Future<void> onSelectTag() async {
    TagTransactionResult result = await _navigationService.push(
      ViewNames.tagsView,
      parameter: TagTransactionType.choose,
    );

    if (result.transactionType == TagTransactionResultType.selectionEmpty)
      assignedTag = null;
    else if (result.transactionType == TagTransactionResultType.changed) {
      assignedTag = TagEntity(
        id: result.tag.id,
        name: result.tag.name,
        created: result.tag.created,
        lastModified: result.tag.lastModified,
      );
    }
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

    if (shouldDelete == true) {
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
