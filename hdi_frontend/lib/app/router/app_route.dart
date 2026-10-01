import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_hdi/app/router/route_name.dart';

import '../../features/auth/login/pages/login_custom.dart';
import '../../features/auth/register/controllers/register_bloc.dart';
import '../../features/auth/register/pages/register.dart';
import '../../features/home/presentation/pages/home_custom.dart';


class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (_) => const HomeCustom(),
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginCustom(),
        );
      case RouteNames.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context)=> RegisterBloc(),
            child: RegisterScreen(),
          )
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}