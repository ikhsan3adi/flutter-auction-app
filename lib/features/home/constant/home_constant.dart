import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';

class HomeConstant {
  static List<Widget> screens = [
    const ExplorePage(),
    const ExplorePage(),
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
