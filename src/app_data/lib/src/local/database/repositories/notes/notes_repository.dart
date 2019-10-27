import 'package:app_data/src/local/database/models/join_query_results.dart';
import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';

class NotesRepository extends BaseRepository<Notes, NoteDataObject> {
  NotesRepository(ENotesDatabase db) : super(db);

  Future<List<NoteDataObject>> selectAllOwnedNotes(String ownedBy) => (select(table)..where((n) => n.ownedBy.equals(ownedBy))).get();

  Stream<List<NoteWithTag>> watchAllOwnedNotes(String ownedBy) {
     final query = (select(table)
        ..where((t) => t.ownedBy.equals(ownedBy)))
        .join([leftOuterJoin(
          db.tags, 
          db.tags.id.equalsExp(db.notes.tagId),
        )]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return NoteWithTag(
          row.readTable(table),
          row.readTable(db.tags),
        );
      }).toList();
    });
  }

  Future<void> deleteOwnedNotes(String ownedBy) => (delete(table)..where((n) => n.ownedBy.equals(ownedBy))).go();

  Stream<List<NoteWithTag>> watchOwnedNotesWithTag(String ownedBy, String tagId) {
    final query = (select(table)
        ..where((t) => t.ownedBy.equals(ownedBy))
        ..where((t) => t.tagId.equals(tagId)))
        .join([leftOuterJoin(
          db.tags, 
          db.tags.id.equalsExp(db.notes.tagId),
        )]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return NoteWithTag(
          row.readTable(table),
          row.readTable(db.tags),
        );
      }).toList();
    });
  }

  @override
  TableInfo<Notes, NoteDataObject> get table => db.notes;
}
