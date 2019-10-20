import 'package:app_business/src/entities/notes/note_entity.dart';
import 'package:app_business/src/mappers/notes/notes_mapper.dart';
import 'package:app_data/database.dart';

abstract class NotesManager {
  Stream<List<NoteEntity>> get notesStream;

  Future<void> addNote(NoteEntity note);

  Future<void> deleteNote(NoteEntity note);

  Future<void> updateNote(NoteEntity note);
}

class NotesManagerImpl implements NotesManager {
  NotesManagerImpl(this._notesRepository, this._notesMapper);

  final NotesRepository _notesRepository;
  final NotesMapper _notesMapper;

  @override
  Future<void> addNote(NoteEntity note) async {
    final noteDO = _notesMapper.toDataObject(note);
    await _notesRepository.insertItem(noteDO);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    final noteDO = _notesMapper.toDataObject(note);
    await _notesRepository.deleteItem(noteDO);
  }

  @override
  Stream<List<NoteEntity>> get notesStream async* {
    await for (final noteDOs in _notesRepository.watchItems()) {
      yield noteDOs.map((n) => _notesMapper.toEntity(n)).toList();
    }
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    final noteDO = _notesMapper.toDataObject(note);
    await _notesRepository.updateItem(noteDO);
  }
}
