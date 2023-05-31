import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';

class HomeConstant {
  static List<Widget> screens = [
    const ExplorePage(),
    const MyBidPage(),
    const MyItemPage(),
    const MyAuctionPage(),
  ];

  static List<String> mainPageAppbarTitles = [
    "E-AUCTION",
    "My Bid",
    "My Item",
    "My Auction",
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
      icon: Icon(Icons.money),
    ),
    const BottomNavigationBarItem(
      label: "My Item",
      tooltip: "My Item",
      icon: Icon(Icons.shopping_bag),
    ),
    const BottomNavigationBarItem(
      label: "My Auction",
      tooltip: "My Auction",
      icon: Icon(Icons.currency_exchange),
    ),
  ];
}
