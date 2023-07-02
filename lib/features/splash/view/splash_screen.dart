import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/splash/splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SplashLogo(),
      ),
    );
  }
}
