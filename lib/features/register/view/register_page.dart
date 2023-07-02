import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/login/models/login_form_state.dart';
import 'package:flutter_online_auction_app/features/register/register.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  /// '/register'
  static const String routeName = '/register';

  static Route<LoginFormState?> route() {
    return MaterialPageRoute<LoginFormState?>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const RegisterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: 'REGISTER'),
      body: BlocProvider(
        create: (context) => RegisterBloc(authenticationRepository: authenticationRepository),
        child: const RegisterScreen(),
      ),
    );
  }
}
