import 'package:smart_notes_data/src/local/database/models/models.dart';
import 'package:smart_notes_data/src/local/database/repositories/base/base_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';

class TagsRepository extends BaseRepository<Tags, TagDataObject> {
  TagsRepository(ENotesDatabase db) : super(db);

  Future<List<TagDataObject>> selectAllTagsNotes(String ownedBy) =>
      (select(table)..where((t) => t.ownedBy.equals(ownedBy))).get();

  Stream<List<TagDataObject>> watchOwnedTags(String ownedBy) =>
      (select(table)..where((t) => t.ownedBy.equals(ownedBy))).watch();

  Future<void> deleteOwnedTags(String ownedBy) =>
      (delete(table)..where((t) => t.ownedBy.equals(ownedBy))).go();

  @override
  TableInfo<Tags, TagDataObject> get table => db.tags;
}
