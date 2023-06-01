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
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: const AuctionFilterChips(),
      body: const MyAuctionScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {/** TODO goto add auction page */},
        label: Text("New Auction", style: textTheme.titleMedium),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
