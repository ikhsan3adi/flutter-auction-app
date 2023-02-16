import 'package:aplikasi_lelang_online/features/explore/explore.dart';
import 'package:aplikasi_lelang_online/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreens extends StatelessWidget {
  MainScreens({super.key});

  final List<Widget> screens = [
    const ExplorePage(),
    // history page
    // profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationLoaded) {
            return screens[state.pageIndex];
          }
          return screens[0];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigationLoaded) {
            return UserBottomNavBar(pageIndex: state.pageIndex);
          }
          return const UserBottomNavBar(pageIndex: 0);
        },
      ),
    );
  }
}
