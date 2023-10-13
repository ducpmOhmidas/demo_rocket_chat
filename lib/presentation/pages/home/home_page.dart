import 'package:flutter/material.dart';
import 'package:flutter_application/design_system_widgets/app_error_widget.dart';
import 'package:flutter_application/design_system_widgets/app_loading_widget.dart';
import 'package:flutter_application/domain/entities/profile_entity.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_bloc.dart';
import 'package:flutter_application/presentation/blocs/auth_navigation/auth_navigation_state.dart';
import 'package:flutter_application/presentation/blocs/home/home_bloc.dart';
import 'package:flutter_application/presentation/blocs/home/home_state.dart';
import 'package:flutter_application/presentation/pages/home/widgets/home_body_widget.dart';
import 'package:flutter_application/presentation/pages/home/widgets/home_drawer_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const path = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().fetchDefaultData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: BlocSelector<AuthBloc, AuthState, ProfileEntity?>(
          selector: (state) =>
              state.mapOrNull(authorized: (auth) => auth.profileModel),
          builder: (context, profile) {
            return HomeDrawerWidget(
              profile: profile,
              onLogin: () {
                context
                    .read<AuthNavigationBloc>()
                    .setState(AuthNavigationState.unAuthorized());
              },
              onLogout: () {
                context.read<AuthBloc>().logout();
                context.read<HomeBloc>().fetchDefaultData();
              },
            );
          }),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return state.when(
            (defaultData) {
              return HomeBodyWidget(defaultData: defaultData);
            },
            loading: () => AppLoadingWidget(),
            error: (e) => AppErrorWidget(error: e),
          );
        }),
      ),
    );
  }
}
