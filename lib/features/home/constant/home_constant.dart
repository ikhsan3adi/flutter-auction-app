import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';

class HomeConstant {
  static List<Widget> screens = [
    const ExplorePage(),
    const MyBidPage(),
  ];

  static List<String> mainPageAppbarTitles = [
    "E-AUCTION",
    "My Bid",
  ];

  static List<BottomNavigationBarItem> mainPageNavbarItems = [
    const BottomNavigationBarItem(
      label: "Explore",
      tooltip: "Explore",
      icon: Icon(Icons.explore),
    ),
    const BottomNavigationBarItem(
      label: "My Bid",
      tooltip: "My Bid",
      icon: Icon(Icons.price_change),
    ),
  ];
}
