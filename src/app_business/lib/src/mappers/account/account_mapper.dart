import 'package:app_business/src/entities/account/account_entity.dart';
import 'package:app_business/src/mappers/account/google_account_mapper.dart';
import 'package:app_business/src/mappers/base/entity_mapper.dart';
import 'package:app_data/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AccountMapper extends EntityDataObjectMapper<AccountEntity, AccountDataObject> {
  AccountEntity toEntityFromGoogleAccount(GoogleSignInAccount source);
}

class AccountMapperImpl implements AccountMapper {
  AccountMapperImpl(this._googleAccountMapper);

  final GoogleAccountMapper _googleAccountMapper;

  @override
  AccountDataObject toDataObject(AccountEntity source) {
    return AccountDataObject(
      id: source.id,
      email: source.email,
      name: source.name,
      imageUrl: source.imageUrl,
    );
  }

  @override
  AccountEntity toEntity(AccountDataObject source) {
    return AccountEntity(
      id: source.id,
      email: source.email,
      name: source.name,
      imageUrl: source.imageUrl,
    );
  }

  @override
  AccountEntity toEntityFromGoogleAccount(GoogleSignInAccount source) => _googleAccountMapper.toEntity(source);
}
