import 'dart:developer';
import 'dart:io';

import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';

import 'package:barbearia_tcc/src/core/fp/either.dart';
import 'package:barbearia_tcc/src/core/fp/nil.dart';
import 'package:barbearia_tcc/src/core/rest_client/rest_client.dart';
import 'package:barbearia_tcc/src/model/user_model.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;
  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(value: data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;

        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválido', error: e, stackTrace: s);
          return Failure(
            exception: AuthUnauthorizedExcetion(),
          );
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(exception: AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');

      return Success(value: UserModel.fromMap(data));
    } on DioException catch (e) {
      log('Erro ao buscar usuário logado', error: e);
      return Failure(
        exception: RepositoryException(
          message: 'Erro ao buscar usuário logado',
        ),
      );
    } on ArgumentError catch (e) {
      log('Invalid json', error: e);
      return Failure(
        exception: RepositoryException(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM',
      });
      return Success<RepositoryException, Nil>(value: Nil());
    } on DioException catch (e, s) {
      log('erro ao registrar usuário admin', error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(
          message: 'Erro ao registrar usuário admin',
        ),
      );
    }
  }
}
