import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/splash/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  /// '/splash'
  static const String routeName = '/splash';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashPage(),
    );
  }

  // splash duration
  Future<bool> _splash() async => await Future.delayed(const Duration(seconds: 3), () => true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _splash(),
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (_, state) {
              if (state is AuthStateAuthorized || state is AuthStateUnauthorized || state is AuthStateUnknown) {
                Navigator.pushReplacementNamed(context, AuthPage.routeName);
              }
            },
            child: const SplashLoading(),
          );
        }

        return const SplashScreen();
      },
    );
  }
}
