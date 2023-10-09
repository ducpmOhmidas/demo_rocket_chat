import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/blocs/home/home_bloc.dart';
import 'package:flutter_application/presentation/pages/home_page.dart';
import 'package:flutter_application/utils/navigator_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigator extends StatefulWidget {
  static const path = '/main_navigator';
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeBloc();
      },
      child: NavigatorSupport(
        initialRoute: HomePage.path,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePage.path:
              return MaterialPageRoute(builder: (context) => const HomePage());
            default:
              return MaterialPageRoute(builder: (context) => Container());
          }
        },
      ),
    );
  }
}
