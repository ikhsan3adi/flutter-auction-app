import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/auction_history/auction_history.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:auction_api/auction_api.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("This is ${settings.name} route");
    }

    switch (settings.name) {
      case HomePage.routeName:
        return HomePage.route();

      case ExplorePage.routeName:
        return ExplorePage.route();

      case AuctionDetailPage.routeName:
        return AuctionDetailPage.route(lelang: settings.arguments as Auction);

      case AuctionHistoryPage.routeName:
        return AuctionHistoryPage.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(
        appBar: MyCustomAppbar(title: 'Error'),
      ),
    );
  }
}
