import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';

class MyAuctionPage extends StatelessWidget {
  /// '/my_auction'
  static const String routeName = '/my_auction';

  const MyAuctionPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyAuctionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MyAuctionScreen();
  }
}
