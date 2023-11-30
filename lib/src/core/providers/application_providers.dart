


import 'package:barbearia_tcc/src/core/rest_client/rest_client.dart';
import 'package:barbearia_tcc/src/repository/user/user_repository.dart';
import 'package:barbearia_tcc/src/repository/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepositoryImpl(restClient: ref.read(restClientProvider));