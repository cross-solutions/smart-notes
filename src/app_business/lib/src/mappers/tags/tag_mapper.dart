import 'package:app_business/src/mappers/base/entity_mapper.dart';
import 'package:app_business/src/entities/tags/tag_entity.dart';
import 'package:app_data/database.dart';

abstract class TagMapper extends EntityDataObjectMapper<TagEntity, TagDataObject> {}

class TagMapperImpl implements TagMapper {
  @override
  TagDataObject toDataObject(TagEntity source) {
    return TagDataObject(
      id: source.id,
      name: source.name,
      ownedBy: source.ownedBy,
      created: source.created,
    );
  }

  @override
  TagEntity toEntity(TagDataObject source) {
    return TagEntity(
      id: source.id,
      name: source.name,
      ownedBy: source.ownedBy,
      created: source.created,
    );
  }
}
