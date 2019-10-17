import 'package:app_data/src/local/database/models/models.dart';
import 'package:app_data/src/local/database/repositories/base/base_repository.dart';

class TagsRepository extends BaseRepository<TagDataObject> {
  TagsRepository(ENotesDatabase db) : super('tags', db);
}
