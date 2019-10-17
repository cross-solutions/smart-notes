import 'package:app_business/src/entities/tags/tag_entity.dart';
import 'package:app_data/database.dart';

abstract class TagsManager {
  Stream<List<TagEntity>> watchTags();
}

class TagsManagerImpl implements TagsManager {
  TagsManagerImpl(this._tagsRepository);

  final TagsRepository _tagsRepository;

  @override
  Stream<List<TagEntity>> watchTags() {
    // TODO: implement watchTags
    return null;
  }
}
