import 'dart:math';

import 'package:app/models/notes/note_item_model.dart';
import 'package:app/services/services.dart';
import 'package:app/view_models/view_models.dart';
import 'package:app_business/entities.dart';
import 'package:app_business/managers.dart';
import 'package:app_util/app_util.dart';
import 'package:uuid/uuid.dart';

class AddOrEditNoteViewModel extends InitializableViewModel<NoteItemModel> {
  AddOrEditNoteViewModel(
    this._notesManager,
    this._tagsManager,
    this._cameraService,
    this._mlVisionService,
    this._navigationService,
    this._dialogService,
  ) {
    _tagsManager.tags.then((tags) {
      this.tags = tags;
    });
  }

  final NotesManager _notesManager;
  final TagsManager _tagsManager;
  final CameraService _cameraService;
  final MLVisionService _mlVisionService;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  void Function(String text) _onTextRecognized;

  List<TagEntity> tags;
  NoteItemModel noteToEdit;

  String get titlePlaceholder {
    final placeholders = ['My awesome note', 'Econ 101', 'Cookie Recipe'];
    final index = Random().nextInt(placeholders.length);

    return placeholders[index];
  }

  void onTextRecognized(void Function(String text) callback) => _onTextRecognized = callback;

  Future<void> onAddOrSaveNote(String title, String content) async {
    try {
      if (title.isEmpty) title = 'Note from ${DateTime.now().toString()}';

      if (noteToEdit != null) {
        await _notesManager.updateNote(NoteEntity(
          id: noteToEdit.id,
          title: title,
          content: content,
        ));
      } else {
        await _notesManager.addNote(NoteEntity(
          id: Uuid().v1(),
          title: title,
          content: content,
        ));
      }
      _navigationService.pop();
    } on Error catch (e) {
      debugError(e.toString());
      await _dialogService.alert('Sorry, we could not create your note.', title: 'Failed to create note');
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
    await _notesManager.deleteNote(NoteEntity(id: noteToEdit.id));
    _navigationService.pop();
  }

  @override
  void initParameter(NoteItemModel parameter) {
    noteToEdit = parameter;
  }
}
