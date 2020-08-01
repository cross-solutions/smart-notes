import 'package:smart_notes_business/src/entities/account/account_entity.dart';
import 'package:smart_notes_business/src/mappers/base/entity_mapper.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAccountMapper
    extends EntityMapper<AccountEntity, GoogleSignInAccount> {}

class GoogleAccountMapperImpl implements GoogleAccountMapper {
  @override
  AccountEntity toEntity(GoogleSignInAccount source) {
    return AccountEntity(
      id: source.id,
      email: source.email,
      name: source.displayName,
      imageUrl:
          source.photoUrl.substring(0, source.photoUrl.length - 4) + '128',
    );
  }
}
