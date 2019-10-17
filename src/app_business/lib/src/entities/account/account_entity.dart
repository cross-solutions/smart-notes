import 'package:app_business/src/entities/base/base_entity.dart';

class AccountEntity extends BaseEntity {
  AccountEntity({
    this.id,
    this.email,
    this.name,
    this.imageUrl,
  });

  final String id;
  final String email;
  final String name;
  final String imageUrl;
}
