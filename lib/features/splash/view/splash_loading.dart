import 'package:flutter/material.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This is splash screen'),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        ),
      ),
    );
  }
}
