import 'package:app_data/src/local/database/models/models.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:meta/meta.dart';

abstract class BaseRepository<T extends DataClass> extends DatabaseAccessor<ENotesDatabase> {
  BaseRepository(this.tableName, ENotesDatabase db) : super(db);

  final String tableName;

  Future<List<T>> selectAll() => select(table).get();

  Future<void> deleteAll() => delete(table).go();

  Future<T> selectSingle() => select(table).getSingle();

  Future<void> deleteItem(T dataObject) => delete(table).delete(dataObject as Insertable);

  Future<void> insertItem(T dataObject) => into(table).insert(dataObject as Insertable);

  Stream<List<T>> watchItems() => select(table).watch();

  @protected
  TableInfo<Table, T> get table => db.allTables.firstWhere((t) => t.actualTableName == tableName);
}
