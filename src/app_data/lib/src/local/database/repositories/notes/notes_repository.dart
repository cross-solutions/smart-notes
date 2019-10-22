import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';

class NotesRepository extends BaseRepository<Notes, NoteDataObject> {
  NotesRepository(ENotesDatabase db) : super(db);

  Stream<List<NoteDataObject>> watchOwnedNotes(String ownedBy) =>
      (select(table)..where((t) => t.ownedBy.equals(ownedBy))).watch();
}
