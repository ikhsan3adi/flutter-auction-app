import 'package:aplikasi_lelang_online/features/explore/explore.dart';
import 'package:aplikasi_lelang_online/models/models.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  static const String routeName = '/explore';

  const ExplorePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ExplorePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExploreScreen(lelangList: Lelang.dummyLelang);
  }
}
