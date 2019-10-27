import 'package:app_business/src/managers/account/account_manager.dart';
import 'package:app_business/src/mappers/account/account_mapper.dart';
import 'package:app_common/constants.dart';
import 'package:app_common/exceptions.dart';
import 'package:app_data/caching.dart';
import 'package:app_data/database.dart';
import 'package:app_data/web_services.dart';

abstract class AuthManager {
  Future<void> ensureUserSignedIn();

  Future<void> signIn();

  Future<void> signOut();
}

class AuthManagerImpl implements AuthManager {
  AuthManagerImpl(
    this._accountManager,
    this._authService,
    this._accountMapper,
    this._keyStoreService,
    this._accountRepository,
  );

  final AccountManager _accountManager;
  final AccountMapper _accountMapper;
  final AuthService _authService;
  final KeyStoreService _keyStoreService;
  final AccountRepository _accountRepository;

  @override
  Future<void> signIn() async {
    final googleAccount = await _authService.signIn();
    final account = _accountMapper.toEntityFromGoogleAccount(googleAccount);
    final accountDO = _accountMapper.toDataObject(account);
    final authHeader = await googleAccount.authHeaders;

    await _keyStoreService.setJson(StorageKeys.authHeader, authHeader);
    await _accountRepository.insertItem(accountDO);
    _accountManager.setCurrentAccount(account);
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
    await _accountRepository.deleteAll();
    await _keyStoreService.delete(StorageKeys.authHeader);
  }

  @override
  Future<void> ensureUserSignedIn() async {
    final isCurrenltySignedIn = await _authService.isCurrentlySignedIn();

    if (isCurrenltySignedIn == true) {
      final googleAccount = await _authService.getCurrentlySignedInAccount();
      final account = _accountMapper.toEntityFromGoogleAccount(googleAccount);
      final accountDO = _accountMapper.toDataObject(account);
      final authHeader = await googleAccount.authHeaders;

      await _keyStoreService.setJson(StorageKeys.authHeader, authHeader);
      await _accountRepository.deleteAll();
      await _accountRepository.insertItem(accountDO);
      _accountManager.setCurrentAccount(account);
    } else
      throw AuthException('Sign in required');
  }
}
