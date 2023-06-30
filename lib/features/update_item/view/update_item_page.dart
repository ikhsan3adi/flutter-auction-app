import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_item/update_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class UpdateItemPage extends StatelessWidget {
  /// '/update_item'
  static const String routeName = '/update_item';

  const UpdateItemPage({super.key, required this.item});

  final Item item;

  static Route<bool?> route({required Item item}) {
    return MaterialPageRoute<bool?>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => UpdateItemPage(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ItemRepository itemRepository = context.read<ItemRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();
    final TokenRepository tokenRepository = context.read<TokenRepository>();

    return BlocProvider(
      create: (context) => UpdateItemBloc(
        itemRepository: itemRepository,
        authenticationRepository: authenticationRepository,
        tokenRepository: tokenRepository,
      )..add(FetchItemData(item: item)),
      child: Scaffold(
        appBar: const MyCustomAppbar(title: 'Update Item'),
        body: UpdateItemScreen(item: item),
      ),
    );
  }
}
