import 'package:flutter_online_auction_app/features/auction_history/auction_history.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreens extends StatelessWidget {
  MainScreens({super.key});

  final List<Widget> screens = [
    const ExplorePage(),
    const AuctionHistoryPage(),
    const ExplorePage(), // profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationLoaded) {
            return screens[state.pageIndex];
          }
          return screens[0];
        },
      ),
      drawer: const MyCustomDrawer(),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationLoaded) {
            return MyCustomBottomNavBar(pageIndex: state.pageIndex);
          }
          return const MyCustomBottomNavBar(pageIndex: 0);
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  _AppBar();

  final List<String> titles = [
    "E-AUCTION",
    "History",
    "Profil",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        if (state is NavigationLoaded) {
          return MyCustomAppbar(title: titles[state.pageIndex]);
        }
        return MyCustomAppbar(title: titles[0]);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
