import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/blocs/home/home_bloc.dart';
import 'package:flutter_application/presentation/pages/forms/forms_page.dart';
import 'package:flutter_application/presentation/pages/home/home_page.dart';
import 'package:flutter_application/utils/navigator_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestNavigator extends StatefulWidget {
  static const path = '/guest_navigator';

  const GuestNavigator({Key? key}) : super(key: key);

  @override
  State<GuestNavigator> createState() => _GuestNavigatorState();
}

class _GuestNavigatorState extends State<GuestNavigator> {
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
              return MaterialPageRoute(
                  builder: (context) => const HomePage(
                        guestMode: true,
                      ));
            case FormsPage.path:
              return MaterialPageRoute(builder: (context) => const FormsPage());
            default:
              return MaterialPageRoute(builder: (context) => Container());
          }
        },
      ),
    );
  }
}
