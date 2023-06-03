import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required NavigatorState navigator, this.child}) : _navigator = navigator;

  final NavigatorState _navigator;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) async {
        if (state is AuthStateAuthorized) {
          _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
        } else {
          _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
        }
      },
      child: child,
    );
  }
}
