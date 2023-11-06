import 'dart:developer';
import 'dart:io';

import 'package:flutter_application/application/services/auth_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:flutter_application/oauth2_interceptor.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_state.dart';
import 'package:flutter_application/utils/cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../ConnectSocketManager.dart';
import '../../../initialize_dependencies.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState.unAuthorized());

  final authNavigationBloc = GetIt.instance.get<AuthNavigationBloc>();

  final authService = GetIt.instance.get<AuthService>();

  final localService = GetIt.instance.get<LocalService>();

  final Oauth2Manager<AuthenticationDto> oauth2manager = sl.get();

  Future login(String userName, String passWord) async {
    final auth = await authService.login(userName, passWord);
    await localService.saveAuth(
        auth: AuthenticationDto(auth.accessToken, auth.userId));
    oauth2manager.add(AuthenticationDto(auth.accessToken, auth.userId));
    final profile = await authService.profile(userId: auth.userId);
    Cache.profile = profile;
    emit(AuthState.authorized(profile));
    authNavigationBloc.setState(AuthNavigationState.authorized());
  }

  void logout() {
    Cache.profile = null;
    localService.saveAuth(auth: null);
    emit(AuthState.unAuthorized());
    authNavigationBloc.setState(AuthNavigationState.guestMode());
  }

  Future initializeApp() async {
    final auth = localService.getAuthenticationDto();
    final socket = sl.get<ConnectSocketManager>();
    socket.on('connect', (p0) => log('ConnectSocketManager: ${socket.connected}'));
    final profile = await authService.profile(userId: auth!.userId);
    Cache.profile = profile;
    emit(AuthState.authorized(profile));
  }
}
