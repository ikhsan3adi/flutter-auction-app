import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppThemeCubit()),
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
          initialRoute: HomePage.routeName,
          home: const HomePage(),
        );
      },
    );
  }
}
