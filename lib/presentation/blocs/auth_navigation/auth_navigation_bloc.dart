import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigationBloc extends Cubit<AuthNavigationState> {
  AuthNavigationBloc() : super(AuthNavigationState.loadConfig());

  void setState(AuthNavigationState authNavigationState) {
    emit(authNavigationState);
  }
}
