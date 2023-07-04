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
    final DioServices dioServices = context.read<DioServices>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppThemeCubit()),
        BlocProvider(
          create: (_) => AuthBloc(
            authenticationRepository: authenticationRepository,
            tokenRepository: tokenRepository,
            dioServices: dioServices,
          )..add(AuthAppStartedEvent()),
        )
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  // splash duration
  Future<bool> _splash() async => await Future.delayed(const Duration(seconds: 4), () => true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          title: "Online Auction App",
          theme: MyAppTheme.theme(),
          darkTheme: MyAppTheme.darkTheme(),
          themeMode: state.themeMode,
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: SplashPage.routeName,
          builder: (context, child) {
            return FutureBuilder(
              future: _splash(),
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data ?? false) return AuthPage(navigator: _navigator, child: child);

                return child ?? const SplashLoading();
              },
            );
          },
        );
      },
    );
  }
}
