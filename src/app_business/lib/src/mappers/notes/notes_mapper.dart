import 'package:app_business/src/entities/notes/note_entity.dart';
import 'package:app_business/src/mappers/base/entity_mapper.dart';
import 'package:app_data/database.dart';

abstract class NotesMapper implements EntityDataObjectMapper<NoteEntity, NoteDataObject> {}

class NotesMapperImpl implements NotesMapper {
  @override
  NoteDataObject toDataObject(NoteEntity source) => NoteDataObject(
        id: source.id,
        title: source.title,
        content: source.content,
        categoryId: source.tagId,
        ownedBy: source.ownedBy,
      );

  @override
  NoteEntity toEntity(NoteDataObject source) => NoteEntity(
        id: source.id,
        title: source.title,
        content: source.content,
        tagId: source.categoryId,
        ownedBy: source.ownedBy
      );
}
