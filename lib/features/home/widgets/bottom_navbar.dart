import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/features/home/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCustomBottomNavBar extends StatelessWidget {
  const MyCustomBottomNavBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return BottomNavigationBar(
      onTap: (index) => context.read<NavigationCubit>().pageChanged(index: index),
      currentIndex: pageIndex,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.secondary,
      showUnselectedLabels: true,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      selectedLabelStyle: textTheme.titleSmall,
      unselectedLabelStyle: textTheme.titleSmall,
      items: HomeConstant.mainPageNavbarItems,
    );
  }
}
