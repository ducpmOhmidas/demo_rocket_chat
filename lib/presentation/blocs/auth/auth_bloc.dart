import 'package:flutter_application/application/services/auth_service.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/data/dtos/authentication_dto.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_state.dart';
import 'package:flutter_application/utils/cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState.unAuthorized());

  final authNavigationBloc = GetIt.instance.get<AuthNavigationBloc>();

  final authService = GetIt.instance.get<AuthService>();

  final localService = GetIt.instance.get<LocalService>();

  Future login(String userName, String passWord) async {
    final auth = await authService.login(userName, passWord);
    final profile = await authService.profile();
    Cache.profile = profile;
    // localService.saveAuth(auth: AuthenticationDto(accessToken, refreshToken));
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
    final profile = await authService.profile();
    Cache.profile = profile;
    emit(AuthState.authorized(profile));
  }
}
