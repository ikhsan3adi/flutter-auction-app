import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';
import 'package:flutter_online_auction_app/features/splash/view/splash_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  /// '/auth'
  static const String routeName = '/auth';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        Navigator.popUntil(context, (route) => route.isFirst);

        if (state is AuthStateAuthorized) {
          Navigator.pushNamed(context, HomePage.routeName);
        } else if (state is AuthStateUnauthorized) {
          if (state.forced) {
            // show dialog
          }
          Navigator.pushNamed(context, LoginPage.routeName);
        } else if (state is AuthStateUnknown) {
          Navigator.pushNamed(context, AuthErrorPage.routeName);
        } else {
          Navigator.pushNamed(context, AuthErrorPage.routeName);
        }
      },
      child: const SplashScreen(),
    );
  }
}
