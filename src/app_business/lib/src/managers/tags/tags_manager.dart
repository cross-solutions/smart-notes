import 'package:app_business/src/entities/tags/tag_entity.dart';
import 'package:app_business/src/mappers/tags/tag_mapper.dart';
import 'package:app_data/database.dart';

abstract class TagsManager {
  Stream<List<TagEntity>> watchTags();

  Future<void> addTag(TagEntity tag);

  Future<void> deleteTag(TagEntity tag);
}

class TagsManagerImpl implements TagsManager {
  TagsManagerImpl(this._tagsRepository, this._tagMapper);

  final TagsRepository _tagsRepository;
  final TagMapper _tagMapper;

  @override
  Stream<List<TagEntity>> watchTags() async* {
    await for (final tagDOs in _tagsRepository.watchItems()) {
      yield tagDOs.map((t) => _tagMapper.toEntity(t)).toList();
    }
  }

  @override
  Future<void> addTag(TagEntity tag) async {
    final tagDO = _tagMapper.toDataObject(tag);
    await _tagsRepository.insertItem(tagDO);
  }

  @override
  Future<void> deleteTag(TagEntity tag) async {
    final tagDO = _tagMapper.toDataObject(tag);
    await _tagsRepository.deleteItem(tagDO);
  }
}
