sealed class AuthException implements Exception {
  final String message;

  AuthException({required this.message});
}

final class AuthError extends AuthException {
  AuthError({required super.message});
}

final class AuthUnauthorizedExcetion extends AuthException {
  AuthUnauthorizedExcetion() : super(message: '');
}
