import 'package:flutter_online_auction_app/features/auction_history/auction_history.dart';
import 'package:flutter/material.dart';

class AuctionHistoryPage extends StatelessWidget {
  static const String routeName = '/auction_history';

  const AuctionHistoryPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuctionHistoryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AuctionHistoryScreen();
  }
}
