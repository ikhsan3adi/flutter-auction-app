import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// '/login'
  static const String routeName = '/login';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authenticationRepository: authenticationRepository),
        child: const LoginScreen(),
      ),
    );
  }
}
