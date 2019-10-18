import 'package:app_business/src/entities/base/base_entity.dart';

class TagEntity extends BaseEntity {
  TagEntity({this.id, this.name});

  final String id;
  final String name;
}
