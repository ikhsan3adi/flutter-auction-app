import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/change_password/change_password.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:user_repository/user_repository.dart';

class ChangePasswordPage extends StatelessWidget {
  /// '/change_password'
  static const String routeName = '/change_password';

  const ChangePasswordPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ChangePasswordPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = context.read<UserRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: "Change Password"),
      body: BlocProvider(
        create: (context) => ChangePasswordBloc(
          userRepository: userRepository,
          authenticationRepository: authenticationRepository,
        ),
        child: Container(),
      ),
    );
  }
}
