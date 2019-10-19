import 'package:moor_flutter/moor_flutter.dart';

part 'models.g.dart';

@UseMoor(tables: [Accounts, Tags, Notes])
class ENotesDatabase extends _$ENotesDatabase {
  ENotesDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db_enotes.sqlite'));

  @override
  int get schemaVersion => 1;
}

@DataClassName('AccountDataObject')
class Accounts extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get email => text()();

  TextColumn get imageUrl => text()();
}

@DataClassName('TagDataObject')
class Tags extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get name => text()();
}

@DataClassName('NoteDataObject')
class Notes extends Table {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  TextColumn get categoryId => text().nullable()();
}
