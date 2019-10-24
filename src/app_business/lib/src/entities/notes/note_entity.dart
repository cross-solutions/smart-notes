import 'package:app_business/entities.dart';
import 'package:app_business/src/entities/base/base_entity.dart';

class NoteEntity extends BaseEntity {
  NoteEntity({
    this.id,
    this.ownedBy,
    this.title,
    this.content,
    this.created,
    this.tag,
  });

  final String id;
  final String ownedBy;
  final String title;
  final String content;
  final DateTime created;
  final TagEntity tag;
}
