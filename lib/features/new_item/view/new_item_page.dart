import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class NewItemPage extends StatelessWidget {
  /// '/new_item'
  static const String routeName = '/new_item';

  const NewItemPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NewItemPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppbar(title: 'New Item'),
      body: BlocProvider(
        create: (context) => NewItemBloc(),
        child: const NewItemScreen(),
      ),
    );
  }
}
