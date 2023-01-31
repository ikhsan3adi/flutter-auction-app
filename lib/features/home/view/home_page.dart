import 'package:aplikasi_lelang_online/shared/shared.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyCustomAppbar(title: "E-LELANG"),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
