import 'package:app_business/src/entities/base/base_entity.dart';

class TagEntity extends BaseEntity {
  TagEntity({
    this.id,
    this.ownedBy,
    this.name,
    this.created,
  });

  final String id;
  final String ownedBy;
  final String name;
  final DateTime created;
}
