import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';

class AccountRepository extends BaseRepository<AccountDataObject> {
  AccountRepository(ENotesDatabase db) : super('accounts', db);
}
