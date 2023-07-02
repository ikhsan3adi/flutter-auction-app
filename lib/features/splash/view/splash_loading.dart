import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/splash/splash.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            const SplashLogo(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
