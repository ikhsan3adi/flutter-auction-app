import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class NewItemPage extends StatelessWidget {
  /// '/new_item'
  static const String routeName = '/new_item';

  const NewItemPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NewItemPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ItemRepository itemRepository = context.read<ItemRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: 'New Item'),
      body: BlocProvider(
        create: (context) => NewItemBloc(
          itemRepository: itemRepository,
          authenticationRepository: authenticationRepository,
        ),
        child: const NewItemScreen(),
      ),
    );
  }
}
