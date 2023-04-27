import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCustomBottomNavBar extends StatelessWidget {
  const MyCustomBottomNavBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BottomNavigationBar(
      onTap: (index) => context.read<NavigationCubit>().pageChanged(index: index),
      currentIndex: pageIndex,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      selectedLabelStyle: textTheme.titleSmall,
      unselectedLabelStyle: textTheme.titleSmall,
      items: const [
        BottomNavigationBarItem(
          label: "Explore",
          tooltip: "Explore",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "History",
          tooltip: "History",
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          label: "Profile",
          tooltip: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
