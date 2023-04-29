import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/splash/splash.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();
    final TokenRepository tokenRepository = context.read<TokenRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppThemeCubit()),
        BlocProvider(
          create: (_) => AuthBloc(
            authenticationRepository: authenticationRepository,
            tokenRepository: tokenRepository,
          )..add(AuthAppStartedEvent()),
        )
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: "Online Auction App",
          theme: MyAppTheme.theme(),
          darkTheme: MyAppTheme.darkTheme(),
          themeMode: state.themeMode,
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: SplashPage.routeName,
          home: const SplashPage(),
        );
      },
    );
  }
}
