import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
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
        BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, state) {
            return SvgPicture.asset(
              'assets/logo/logo.svg',
              theme: SvgTheme(currentColor: state.themeMode == ThemeMode.dark ? Colors.white : Colors.black87),
              height: MediaQuery.of(context).size.height / 5,
            );
          },
        ),
        Text("E-AUCTION", style: textTheme.headlineLarge),
        const Text('Online Auction App'),
      ],
    );
  }
}
