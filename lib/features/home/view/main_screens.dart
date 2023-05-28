import 'package:flutter_online_auction_app/features/home/constant/constant.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreens extends StatelessWidget {
  const MainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return HomeConstant.screens[(state is NavigationLoaded) ? state.pageIndex : 0];
        },
      ),
      drawer: const MyCustomDrawer(),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return MyCustomBottomNavBar(pageIndex: (state is NavigationLoaded) ? state.pageIndex : 0);
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return MyCustomAppbar(
          title: HomeConstant.mainPageAppbarTitles[(state is NavigationLoaded) ? state.pageIndex : 0],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
