import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/features/home/view/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  /// '/home'
  static const String routeName = '/home';

  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuctionRepository auctionRepository = context.read<AuctionRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubit()..pageChanged(index: 0),
        ),
        BlocProvider(
          create: (_) {
            return ExploreBloc(
              auctionRepository: auctionRepository,
              authenticationRepository: authenticationRepository,
            )..add(ExploreFetchAuctionEvent());
          },
        ),
      ],
      child: MainScreens(),
    );
  }
}
