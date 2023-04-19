import 'package:aplikasi_lelang_online/features/auction_detail/auction_detail.dart';
import 'package:auction_api/auction_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionDetailPage extends StatelessWidget {
  /// '/auction_detail'
  static const String routeName = '/auction_detail';

  const AuctionDetailPage({super.key, required this.lelang});

  final Auction lelang;

  static Route<void> route({required Auction lelang}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AuctionDetailPage(lelang: lelang),
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
            return AuctionDetailBloc()..add(AuctionDetailGetAuctionEvent(lelang));
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
