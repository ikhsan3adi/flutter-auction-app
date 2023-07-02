import 'package:flutter/material.dart';
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
  Future<bool> _splash() async => await Future.delayed(const Duration(seconds: 2), () => true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _splash(),
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return const SplashLoading();
        }

        return const SplashScreen();
      },
    );
  }
}
