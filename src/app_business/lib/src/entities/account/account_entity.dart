import 'package:app_business/src/entities/base/base_entity.dart';

class AccountEntity extends BaseEntity {
  AccountEntity({
    this.id,
    this.email,
    this.displayName,
    this.imageUrl,
  });

  String id;
  String email;
  String displayName;
  String imageUrl;
}
