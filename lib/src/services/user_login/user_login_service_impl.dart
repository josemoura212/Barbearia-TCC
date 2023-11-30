import 'package:barbearia_tcc/src/core/constants/local_storage_keys.dart';
import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/exceptions/service_exception.dart';

import 'package:barbearia_tcc/src/core/fp/either.dart';

import 'package:barbearia_tcc/src/core/fp/nil.dart';
import 'package:barbearia_tcc/src/repository/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Nil>> execute({
    required String email,
    required String password,
  }) async {
    final loginResult =
        await userRepository.login(email: email, password: password);

    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Success(value: nil);
      case Failure(:final exception):
        return switch (exception) {
          AuthError() => Failure(
              exception: ServiceException(message: 'erro ao realizar login'),
            ),
          AuthUnauthorizedExcetion() => Failure(
              exception: ServiceException(message: 'Login ou senha inválidos'),
            ),
        };
    }
  }
}
