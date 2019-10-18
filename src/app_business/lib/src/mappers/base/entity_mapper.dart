import 'package:app_business/src/entities/base/base_entity.dart';
import 'package:moor_flutter/moor_flutter.dart';

abstract class EntityMapper<TEntity extends BaseEntity, TSource> {
  TEntity toEntity(TSource source);
}

abstract class DataObjectMapper<TDataObject extends DataClass, TSource> {
  TDataObject toDataObject(TSource source);
}

abstract class EntityDataObjectMapper<TEntity extends BaseEntity, TDataObject extends DataClass>
    implements EntityMapper<TEntity, TDataObject>, DataObjectMapper<TDataObject, TEntity> {}
