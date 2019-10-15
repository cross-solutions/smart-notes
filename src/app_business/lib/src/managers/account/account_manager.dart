import 'package:app_business/src/entities/account/account_entity.dart';
import 'package:app_util/app_util.dart';

abstract class AccountManager {
  AccountEntity get currentAccount;

  void setCurrentAccount(AccountEntity account);
}

class AccountManagerImpl implements AccountManager {
  AccountEntity _currentAccount;

  @override
  AccountEntity get currentAccount => _currentAccount;

  @override
  void setCurrentAccount(AccountEntity account) {
    _currentAccount = account;
    debugInfo('Signed-in as ${_currentAccount.email} (${_currentAccount.displayName})');
  }
}
