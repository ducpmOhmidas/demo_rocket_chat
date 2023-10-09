import 'package:flutter/material.dart';
import 'package:flutter_application/application/services/local_service.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_state.dart';
import 'package:flutter_application/presentation/pages/navigator/auth_navigator.dart';
import 'package:flutter_application/presentation/pages/navigator/main_navigator.dart';
import 'package:flutter_application/presentation/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Application extends StatefulWidget {
  static const path = 'Application';
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthNavigationBloc, AuthNavigationState>(
        bloc: context.read<AuthNavigationBloc>(),
        builder: (context, state) {
          return state.when(
              authorized: () => MainNavigator(),
              unAuthorized: () => AuthNavigator(),
              guestMode: () => MainNavigator(),
              loadConfig: () => SplashPage(initializeApp: (context) async {
                    if (GetIt.instance.get<LocalService>().isAuthorized()) {
                      return AuthNavigationState.authorized();
                    } else {
                      return AuthNavigationState.guestMode();
                    }
                  }));
        },
        buildWhen: (stateOld, stateCurrent) {
          return stateOld.runtimeType != stateCurrent.runtimeType;
        },
      ),
    );
  }
}
