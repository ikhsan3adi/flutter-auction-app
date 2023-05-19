import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  /// '/explore'
  static const String routeName = '/explore';

  const ExplorePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ExplorePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExploreScreen();
  }
}
