import 'package:aplikasi_lelang_online/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBottomNavBar extends StatelessWidget {
  final int pageIndex;

  const UserBottomNavBar({super.key, required this.pageIndex});

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
          label: "Jelajahi",
          tooltip: "Jelajahi",
          icon: Icon(Icons.explore),
        ),
        BottomNavigationBarItem(
          label: "Riwayat",
          tooltip: "Riwayat",
          icon: Icon(Icons.history),
        ),
        BottomNavigationBarItem(
          label: "Profil",
          tooltip: "Profil",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}

class AdminBottomNavBar extends StatelessWidget {
  final int pageIndex;

  const AdminBottomNavBar({super.key, required this.pageIndex});

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
          label: "Dashboard",
          tooltip: "Dashboard",
          icon: Icon(Icons.dashboard),
        ),
        BottomNavigationBarItem(
          label: "Profil",
          tooltip: "Profil",
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
