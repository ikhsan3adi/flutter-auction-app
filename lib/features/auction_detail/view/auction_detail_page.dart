import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionDetailPage extends StatelessWidget {
  /// '/auction_detail'
  static const String routeName = '/auction_detail';

  const AuctionDetailPage({super.key, required this.auction});

  final Auction auction;

  static Route<void> route({required Auction auction}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AuctionDetailPage(auction: auction),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AuctionDetailBloc()..add(AuctionDetailGetAuctionEvent(auction));
          },
        ),
        BlocProvider(
          create: (context) => AppbarCubit()..scrolled(0),
        ),
      ],
      child: const AuctionDetailScreen(),
    );
  }
}
