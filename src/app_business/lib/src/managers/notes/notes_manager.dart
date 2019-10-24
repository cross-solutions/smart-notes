import 'package:app_business/src/entities/notes/note_entity.dart';
import 'package:app_business/src/mappers/notes/note_mapper.dart';
import 'package:app_data/database.dart';

abstract class NotesManager {
  Stream<List<NoteEntity>> getNotesStream(String ownedBy);

  Stream<List<NoteEntity>> getNotesWithTagStream(String ownedBy, String tagId);

  Future<void> addNote(NoteEntity note);

  Future<void> deleteNote(NoteEntity note);

  Future<void> updateNote(NoteEntity note);
}

class NotesManagerImpl implements NotesManager {
  NotesManagerImpl(
    this._notesRepository,
    this._noteMapper,
    this._noteWithTagMapper,
  );

  final NotesRepository _notesRepository;
  final NoteMapper _noteMapper;
  final NoteWithTagMapper _noteWithTagMapper;

  @override
  Future<void> addNote(NoteEntity note) async {
    var noteDO = _noteMapper.toDataObject(note);
    await _notesRepository.insertItem(noteDO);
  }

  @override
  Future<void> deleteNote(NoteEntity note) async {
    final noteDO = _noteMapper.toDataObject(note);
    await _notesRepository.deleteItem(noteDO);
  }

  @override
  Stream<List<NoteEntity>> getNotesStream(String ownedBy) async* {
    await for (final noteDOs in _notesRepository.watchAllOwnedNotes(ownedBy)) {
      yield noteDOs.map((n) => _noteWithTagMapper.toEntity(n)).toList();
    }
  }

  @override
  Future<void> updateNote(NoteEntity note) async {
    final noteDO = _noteMapper.toDataObject(note);
    await _notesRepository.updateItem(noteDO);
  }

  @override
  Stream<List<NoteEntity>> getNotesWithTagStream(String ownedBy, String tagId) async* {
    await for (final noteDOs in _notesRepository.watchOwnedNotesWithTag(ownedBy, tagId)) {
      yield noteDOs.map((n) => _noteWithTagMapper.toEntity(n)).toList();
    }
  }
}
