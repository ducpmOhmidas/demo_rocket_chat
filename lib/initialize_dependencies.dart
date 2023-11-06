import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application/ConnectSocketManager.dart';
import 'package:flutter_application/application/services/auth_service.dart';
import 'package:flutter_application/application/services/chat_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/application/services/user_service.dart';
import 'package:flutter_application/data/impl_repositories/auth/auth_local_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/auth/auth_mock_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/chat/chat_api_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/chat/chat_local_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/room/room_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/user/user_api_repository_impl.dart';
import 'package:flutter_application/data/impl_repositories/user/user_local_repository_impl.dart';
import 'package:flutter_application/domain/repositories/auth/auth_api_repository.dart';
import 'package:flutter_application/domain/repositories/auth/auth_local_reposirory.dart';
import 'package:flutter_application/domain/repositories/auth/auth_mock_repository.dart';
import 'package:flutter_application/domain/repositories/chat/chat_api_repository.dart';
import 'package:flutter_application/domain/repositories/chat/chat_local_repository.dart';
import 'package:flutter_application/domain/repositories/room/room_repository.dart';
import 'package:flutter_application/domain/repositories/user/user_api_repository.dart';
import 'package:flutter_application/domain/repositories/user/user_local_repository.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/dtos/authentication_dto.dart';
import 'data/impl_repositories/auth/auth_api_repository_impl.dart';
import 'oauth2_interceptor.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final sl = GetIt.I;

Future initializeDependencies() async {
  final baseUrl = dotenv.get('BASE_URL');
  final baseImageUrl = dotenv.get('BASE_IMAGE_URL');
  final rocketChatServer = dotenv.get('ROCKET_CHAT_SERVER');

  //region local IO

  final _sharedPres = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => _sharedPres);

  //endregion

  //region repo

  sl.registerLazySingleton<AuthApiRepository>(() => AuthApiRepositoryImpl());
  sl.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepositoryImpl());
  sl.registerLazySingleton<AuthMockRepository>(() => AuthMockRepositoryImpl());
  sl.registerLazySingleton<RoomRepository>(() => RoomRepositoryImpl());
  sl.registerLazySingleton<ChatApiRepository>(() => ChatApiRepositoryImpl());
  sl.registerLazySingleton<ChatLocalRepository>(
      () => ChatLocalRepositoryImpl());
  sl.registerLazySingleton<UserApiRepository>(() => UserApiRepositoryImpl());
  sl.registerLazySingleton<UserLocalRepository>(
      () => UserLocalRepositoryImpl());

  //endregion

  //region service

  sl.registerLazySingleton(() => LocalService());
  sl.registerLazySingleton(() => ChatService(baseImageUrl,
      chatApiRepository: sl.get(), chatLocalRepository: sl.get()));
  sl.registerLazySingleton(() => UserService(baseImageUrl,
      userApiRepository: sl.get(), userLocalRepository: sl.get()));


  //endregion

  //region state

  sl.registerLazySingleton(() => AuthNavigationBloc());
  sl.registerLazySingleton(() => AuthService(sl(), sl(), sl()));
  sl.registerLazySingleton(() => AuthBloc());

  //endregion

  //region network server

  Dio dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Oauth2Manager<AuthenticationDto> oauth2manager =
      Oauth2Manager<AuthenticationDto>(
          currentValue: sl.get<LocalService>().getAuthenticationDto(),
          onSave: (value) {
            log('onSave: $value');
            if (value == null) {
              sl.get<LocalService>().saveAuth(auth: null);
            } else {
              sl.get<LocalService>().saveAuth(auth: value);
            }
          });

  sl.registerLazySingleton<Oauth2Manager<AuthenticationDto>>(
      () => oauth2manager);

  dio.interceptors.add(
    Oauth2Interceptor(
      dio: dio,
      oauth2Dio: Dio(BaseOptions(baseUrl: baseUrl)),
      pathRefreshToken: '',
      parserJson: (json) {
        return AuthenticationDto.fromJson(json as Map<String, dynamic>);
      },
      tokenProvider: oauth2manager,
    ),
  );

  sl.registerLazySingleton(() => dio);

  sl.registerLazySingleton(() => ConnectSocketManager(rocketChatServer: rocketChatServer));
  //endregion
}
