import 'package:app_business/src/entities/tags/tag_entity.dart';
import 'package:app_business/src/mappers/tags/tag_mapper.dart';
import 'package:app_data/database.dart';

abstract class TagsManager {
  Future<List<TagEntity>> get tags;

  Stream<List<TagEntity>> getTagsStream(String ownedBy);

  Future<TagEntity> getTag(String id);

  Future<void> addTag(TagEntity tag);

  Future<void> deleteTag(TagEntity tag);
}

class TagsManagerImpl implements TagsManager {
  TagsManagerImpl(this._tagsRepository, this._tagMapper);

  final TagsRepository _tagsRepository;
  final TagMapper _tagMapper;

  @override
  Stream<List<TagEntity>> getTagsStream(String ownedBy) async* {
    await for (final tagDOs in _tagsRepository.watchOwnedTags(ownedBy)) {
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

  @override
  Future<TagEntity> getTag(String id) async {
    final results = await _tagsRepository.selectAll();
    final match = results.firstWhere((t) => t.id == id);

    if (match != null)
      return _tagMapper.toEntity(match);
    else
      return null;
  }

  @override
  Future<List<TagEntity>> get tags async {
    final results = await _tagsRepository.selectAll();
    return results.map((t) => _tagMapper.toEntity(t)).toList();
  }
}
