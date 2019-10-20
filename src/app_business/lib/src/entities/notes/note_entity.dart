import 'package:app_business/src/entities/base/base_entity.dart';

class NoteEntity extends BaseEntity {
  NoteEntity({
    this.id,
    this.title,
    this.content,
    this.tagId,
  });

  final String id;
  final String title;
  final String content;
  final String tagId;
}
