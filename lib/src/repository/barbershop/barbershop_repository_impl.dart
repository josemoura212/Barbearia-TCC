import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';

import 'package:barbearia_tcc/src/core/fp/either.dart';
import 'package:barbearia_tcc/src/core/rest_client/rest_client.dart';

import 'package:barbearia_tcc/src/model/barbershop_model.dart';

import 'package:barbearia_tcc/src/model/user_model.dart';
import 'package:dio/dio.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;

  BarbershopRepositoryImpl({required this.restClient});
  @override
  Future<Either<RepositoryException, BarbershopModel>> getBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );
        return Success(value: BarbershopModel.fromMap(data));
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbeariaId}}',
        );
        return Success(value: BarbershopModel.fromMap(data));
    }
  }
}
