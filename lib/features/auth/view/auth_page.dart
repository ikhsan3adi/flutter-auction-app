import 'package:flutter/material.dart';

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
    return const Placeholder();
  }
}
