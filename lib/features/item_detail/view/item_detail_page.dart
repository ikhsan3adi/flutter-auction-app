import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/item_detail/item_detail.dart';
import 'package:flutter_online_auction_app/features/update_item/update_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemDetailPage extends StatelessWidget {
  /// '/item_detail'
  static const String routeName = '/item_detail';

  const ItemDetailPage({super.key, required this.item});

  final Item item;

  static Route<void> route({required Item item}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ItemDetailPage(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ItemRepository itemRepository = context.read<ItemRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ItemDetailBloc(
              authenticationRepository: authenticationRepository,
              itemRepository: itemRepository,
            )..add(ItemDetailGetItemEvent(item));
          },
        ),
        BlocProvider(
          create: (context) => CarouselCubit(controller: CarouselController()),
        )
      ],
      child: Scaffold(
        appBar: const MyCustomAppbar(title: 'Item Detail'),
        body: ItemDetailScreen(item: item),
        bottomNavigationBar: _ActionButton(item: item),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: CustomIconButton(
              onPressed: () {
                Navigator.of(context).pushNamed<bool?>(UpdateItemPage.routeName, arguments: item).then((value) {
                  if ((value ?? false) && context.read<ItemDetailBloc>().state is ItemDetailLoaded) {
                    context.read<ItemDetailBloc>().add(ItemDetailGetItemEvent(item));
                  }
                });
              },
              icon: const Icon(Icons.edit),
              text: 'Edit',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: CustomIconButton(
              disabled: item.auctioned,
              icon: const Icon(Icons.delete_forever, size: 28),
              backgroundColor: theme.colorScheme.error,
              onPressed: () async {
                Fluttertoast.cancel();
                if (item.auctioned) {
                  Fluttertoast.showToast(msg: "Auctioned item can't be deleted");
                } else {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmDialog(),
                  ).then((delete) {
                    if (delete ?? false) {
                      Fluttertoast.showToast(msg: 'Deleting bid...');
                      context.read<ItemDetailBloc>().add(DeleteItem(item: item));
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
