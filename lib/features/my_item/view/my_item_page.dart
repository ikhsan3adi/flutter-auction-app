import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';

class MyItemPage extends StatelessWidget {
  /// '/my_item'
  static const String routeName = '/my_item';

  const MyItemPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyItemPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MyItemScreen();
  }
}
