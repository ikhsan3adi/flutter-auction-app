import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';

class AuthErrorPage extends StatelessWidget {
  const AuthErrorPage({super.key});

  /// '/auth_error'
  static const String routeName = '/auth_error';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthErrorPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Auth error page'),
                ...(state as AuthStateError).messages.map((e) => Text('Message: $e')),
              ],
            );
          },
        ),
      ),
    );
  }
}
