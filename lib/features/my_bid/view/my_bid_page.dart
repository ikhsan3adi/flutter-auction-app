import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';

class MyBidPage extends StatelessWidget {
  /// '/my_bid'
  static const String routeName = '/my_bid';

  const MyBidPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyBidPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyBidFilterChips(),
      body: MyBidScreen(),
    );
  }
}
