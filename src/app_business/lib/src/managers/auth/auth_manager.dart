import 'package:app_business/src/managers/account/account_manager.dart';
import 'package:app_business/src/mappers/account/account_mapper.dart';
import 'package:app_data/app_data.dart';

abstract class AuthManager {
  Future<void> signIn();

  Future<void> signOut();

  Future<void> ensureUserAlreadySignedIn();
}

class AuthManagerImpl implements AuthManager {
  AuthManagerImpl(this._accountManager, this._authService, this._accountMapper);

  final AccountManager _accountManager;
  final AccountMapper _accountMapper;
  final AuthService _authService;

  @override
  Future<void> ensureUserAlreadySignedIn() async {
    final googleAccount = await _authService.getCurrentlySignedInAccount();
    final account = _accountMapper.toEntity(googleAccount);
    _accountManager.setCurrentAccount(account);
  }

  @override
  Future<void> signIn() async {
    final googleAccount = await _authService.signIn();
    final account = _accountMapper.toEntity(googleAccount);
    _accountManager.setCurrentAccount(account);
  }

  @override
  Future<void> signOut() => _authService.signOut();
}
