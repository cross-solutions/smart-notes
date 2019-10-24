import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';


class AccountRepository extends BaseRepository<Accounts, AccountDataObject> {
  AccountRepository(ENotesDatabase db) : super(db);

  @override
  TableInfo<Accounts, AccountDataObject> get table => db.accounts;
}
