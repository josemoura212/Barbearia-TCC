import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/fp/either.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login({
    required String email,
    required String password,
  });
}
