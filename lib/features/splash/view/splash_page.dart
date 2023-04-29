import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';

import 'splash_screen.dart';

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

  Future<void> _splash() async => await Future.delayed(const Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    _splash().then((value) => Navigator.pushReplacementNamed(context, AuthPage.routeName));
    return const SplashScreen();
  }
}
