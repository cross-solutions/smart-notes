import 'package:app_business/src/entities/base/base_entity.dart';

class NoteEntity extends BaseEntity {
  NoteEntity({
    this.id,
    this.ownedBy,
    this.title,
    this.content,
    this.tagId,
  });

  final String id;
  final String ownedBy;
  final String title;
  final String content;
  final String tagId;
}
