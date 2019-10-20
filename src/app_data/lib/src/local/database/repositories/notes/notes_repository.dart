import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';

class NotesRepository extends BaseRepository {
  NotesRepository(ENotesDatabase db) : super('notes', db);
}
