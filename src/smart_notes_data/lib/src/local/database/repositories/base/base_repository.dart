import 'package:smart_notes_data/src/local/database/models/models.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:meta/meta.dart';

abstract class BaseRepository<TTable extends Table,
    TDataObject extends DataClass> extends DatabaseAccessor<ENotesDatabase> {
  BaseRepository(ENotesDatabase db) : super(db);

  Future<List<TDataObject>> selectAll() => select(table).get();

  Future<void> deleteAll() => delete(table).go();

  Future<TDataObject> selectSingle() => select(table).getSingle();

  Future<void> deleteItem(TDataObject dataObject) =>
      delete(table).delete(dataObject as Insertable);

  Future<void> insertItem(TDataObject dataObject) =>
      into(table).insert(dataObject as Insertable);

  Future<void> insertItems(List<TDataObject> dataObject) =>
      db.batch((b) => b.insertAll(table, dataObject as List<Insertable>));

  Stream<List<TDataObject>> watchItems() => select(table).watch();

  Future<void> updateItem(TDataObject dataObject) =>
      update(table).replace(dataObject as Insertable);

  @protected
  TableInfo<TTable, TDataObject> get table;
}
