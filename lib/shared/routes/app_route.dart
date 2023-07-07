import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/auth/auth.dart';
import 'package:flutter_online_auction_app/features/change_password/change_password.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/features/item_detail/item_detail.dart';
import 'package:flutter_online_auction_app/features/login/login.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/features/new_auction/new_auction.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/features/register/register.dart';
import 'package:flutter_online_auction_app/features/splash/splash.dart';
import 'package:flutter_online_auction_app/features/update_item/update_item.dart';
import 'package:flutter_online_auction_app/features/update_profile/update_profile.dart';
import 'package:flutter_online_auction_app/features/user_profile/user_profile.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("This is ${settings.name} route");
    }

    switch (settings.name) {
      case SplashPage.routeName:
        return SplashPage.route();

      case AuthErrorPage.routeName:
        return AuthErrorPage.route();

      case LoginPage.routeName:
        return LoginPage.route();

      case RegisterPage.routeName:
        return RegisterPage.route();

      case HomePage.routeName:
        return HomePage.route();

      case ExplorePage.routeName:
        return ExplorePage.route();

      case AuctionDetailPage.routeName:
        return AuctionDetailPage.route(auction: settings.arguments as Auction);

      case MyBidPage.routeName:
        return MyBidPage.route();

      case MyItemPage.routeName:
        return MyItemPage.route();

      case ItemDetailPage.routeName:
        return ItemDetailPage.route(item: settings.arguments as Item);

      case UpdateItemPage.routeName:
        return UpdateItemPage.route(item: settings.arguments as Item);

      case NewItemPage.routeName:
        return NewItemPage.route();

      case MyAuctionPage.routeName:
        return MyAuctionPage.route();

      case NewAuctionPage.routeName:
        return NewAuctionPage.route();

      case UserProfilePage.routeName:
        return UserProfilePage.route();

      case UpdateProfilePage.routeName:
        return UpdateProfilePage.route(user: settings.arguments as User);

      case ChangePasswordPage.routeName:
        return ChangePasswordPage.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(
        appBar: MyCustomAppbar(title: 'Error'),
        body: ErrorCommon(message: "Error"),
      ),
    );
  }
}
