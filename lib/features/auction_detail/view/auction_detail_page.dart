import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class AuctionDetailPage extends StatelessWidget {
  /// '/auction_detail'
  static const String routeName = '/auction_detail';

  const AuctionDetailPage({super.key, required this.auction});

  final Auction auction;

  static Route<bool?> route({required Auction auction}) {
    return MaterialPageRoute<bool?>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AuctionDetailPage(auction: auction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuctionRepository auctionRepository = context.read<AuctionRepository>();
    final BidRepository bidRepository = context.read<BidRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AuctionDetailBloc(
              auctionRepository: auctionRepository,
              bidRepository: bidRepository,
              authenticationRepository: authenticationRepository,
            )..add(AuctionDetailGetAuctionEvent(auction));
          },
        ),
        BlocProvider(
          create: (_) => AppbarCubit(
            theme: Theme.of(context),
            themeMode: context.read<AppThemeCubit>().state.themeMode,
          )..scrolled(0),
        ),
      ],
      child: AuctionDetailScreen(auction: auction),
    );
  }
}
