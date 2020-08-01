class OperationCanceledException extends ExceptionBase {
  OperationCanceledException(String message) : super(message);
}

class AuthException extends ExceptionBase {
  AuthException(String message) : super(message);
}

abstract class ExceptionBase implements Exception {
  ExceptionBase(this.message);
  final String message;
}
