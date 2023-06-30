import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/features/my_item/widgets/item_filter_chips.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';

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
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: const ItemFilterChips(),
      body: const MyItemScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed<bool?>(context, NewItemPage.routeName).then((value) {
            if ((value ?? false) && context.read<MyItemBloc>().state is MyItemLoaded) {
              context.read<MyItemBloc>().add(FetchMyItem());
            }
          });
        },
        label: Text("New Item", style: textTheme.titleMedium),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
