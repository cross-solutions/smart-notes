import 'package:app_common/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:app_util/app_util.dart';
import 'package:googleapis/drive/v3.dart';

abstract class AuthService {
  Future<GoogleSignInAccount> getCurrentlySignedInAccount();

  Future<GoogleSignInAccount> signIn();

  Future<void> signOut();

  Future<bool> isCurrentlySignedIn();
}

class AuthServiceImpl extends AuthService {
  final _googleAuth = GoogleSignIn(
    scopes: <String>[
      'email',
      DriveApi.DriveAppdataScope,
    ],
  );

  @override
  Future<GoogleSignInAccount> getCurrentlySignedInAccount() async {
    final account = await _googleAuth.signInSilently();

    if (account == null)
      throw AuthException('Sign in required');
    else
      return _googleAuth.signInSilently();
  }

  @override
  Future<GoogleSignInAccount> signIn() async {
    try {
      if (_googleAuth.currentUser != null)
        return _googleAuth.currentUser;
      else {
        final account = await _googleAuth.signIn();

        if (account == null)
          throw OperationCanceledException('Sign in was canceled');
        else
          return account;
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'sign_in_failed':
          throw AuthException('Sign in failed');
        default:
          debugError('${e.code} ${e.message}');
          rethrow;
      }
    }
  }

  @override
  Future<void> signOut() => _googleAuth.signOut();

  @override
  Future<bool> isCurrentlySignedIn() => _googleAuth.isSignedIn();
}
