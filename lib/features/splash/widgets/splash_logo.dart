import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/logo/logo.svg',
          theme: SvgTheme(currentColor: textTheme.headlineLarge?.color ?? Colors.black87),
          height: MediaQuery.of(context).size.height / 5,
        ),
        Text("E-AUCTION", style: textTheme.headlineLarge),
        const Text('Online Auction App'),
      ],
    );
  }
}
