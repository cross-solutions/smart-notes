import 'package:smart_notes_business/src/entities/base/base_entity.dart';

class TagEntity extends BaseEntity {
  TagEntity({
    this.id,
    this.ownedBy,
    this.name,
    this.created,
    this.lastModified,
  });

  final String id;
  final String ownedBy;
  final String name;
  final DateTime created;
  final DateTime lastModified;
}
