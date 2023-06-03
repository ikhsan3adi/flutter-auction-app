import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';

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
    final TokenRepository tokenRepository = context.read<TokenRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();
    final AuctionRepository auctionRepository = context.read<AuctionRepository>();
    final ItemRepository itemRepository = context.read<ItemRepository>();

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
        BlocProvider(
          create: (_) {
            return MyBidBloc(
              auctionRepository: auctionRepository,
              authenticationRepository: authenticationRepository,
              tokenRepository: tokenRepository,
            );
          },
        ),
        BlocProvider(
          create: (_) {
            return MyItemBloc(
              itemRepository: itemRepository,
              authenticationRepository: authenticationRepository,
            );
          },
        ),
        BlocProvider(
          create: (_) {
            return MyAuctionBloc(
              auctionRepository: auctionRepository,
              authenticationRepository: authenticationRepository,
            );
          },
        ),
      ],
      child: const MainScreens(),
    );
  }
}
