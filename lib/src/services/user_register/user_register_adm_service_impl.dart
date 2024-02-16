import 'dart:developer';

import 'package:barbearia_tcc/src/core/exceptions/service_exception.dart';

import 'package:barbearia_tcc/src/core/fp/either.dart';

import 'package:barbearia_tcc/src/core/fp/nil.dart';
import 'package:barbearia_tcc/src/repository/user/user_repository.dart';
import 'package:barbearia_tcc/src/services/user_login/user_login_service.dart';

import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserRegisterAdmServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({
        String name,
        String email,
        String password,
      }) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);

    switch (registerResult) {
      case Success():
        return userLoginService.execute(
          email: userData.email,
          password: userData.password,
        );
      case Failure(:final exception):
        return Failure(
            exception: ServiceException(
          message: exception.message,
        ));
    }
  }
}
