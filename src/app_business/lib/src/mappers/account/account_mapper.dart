import 'package:app_business/src/entities/account/account_entity.dart';
import 'package:app_business/src/mappers/base/entity_mapper.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AccountMapper implements EntityMapper<AccountEntity, GoogleSignInAccount> {}

class AccountMapperImpl implements AccountMapper {
  @override
  AccountEntity toEntity(GoogleSignInAccount source) {
    return AccountEntity(
      id: source.id,
      email: source.email,
      displayName: source.displayName,
      imageUrl: source.photoUrl.substring(0, source.photoUrl.length - 4) + '128'
    );
  }
}
