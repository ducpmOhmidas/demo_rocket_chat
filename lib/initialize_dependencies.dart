import 'package:dio/dio.dart';
import 'package:flutter_application/application/services/auth_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/data_sources/local/auth_local_data_source.dart';
import 'package:flutter_application/data/data_sources/mock/auth_mock_data_source.dart';
import 'package:flutter_application/data/data_sources/remote/auth_api_data_source.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/dtos/authentication_dto.dart';
import 'oauth2_interceptor.dart';

const baseUrl = 'https://chat.ohmidasvn.dev/api/v1';

Future initializeDependencies() async {
  Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl
  ));
  GetIt.instance.registerSingleton(await SharedPreferences.getInstance());

  GetIt.instance.registerSingleton(AuthNavigationBloc());
  GetIt.instance.registerSingleton(LocalService());
  GetIt.instance.registerSingleton(AuthService(
      AuthMockDataSource(), AuthLocalDataSource(), AuthApiDataSource()));
  GetIt.instance.registerSingleton(AuthBloc());

  Oauth2Manager<AuthenticationDto> oauth2manager =
      Oauth2Manager<AuthenticationDto>(
          currentValue:
              GetIt.instance.get<LocalService>().getAuthenticationDto(),
          onSave: (value) {
            if (value == null) {
              GetIt.instance.get<LocalService>().saveAuth(auth: null);
            } else {
              GetIt.instance.get<LocalService>().saveAuth(auth: value);
            }
          });

  GetIt.instance
      .registerSingleton<Oauth2Manager<AuthenticationDto>>(oauth2manager);

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
}
