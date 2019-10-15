import 'package:app_business/src/entities/base/base_entity.dart';

abstract class EntityMapper<TEntity extends BaseEntity, TSource> {
  TEntity toEntity(TSource source);
}
