import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<MyItemBloc>().state is MyItemInitial) {
      context.read<MyItemBloc>().add(FetchMyItem());
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async => context.read<MyItemBloc>().add(FetchMyItem()),
      child: BlocBuilder<MyItemBloc, MyItemState>(
        builder: (context, state) {
          if (state is MyItemError) return ErrorCommon(message: state.messages.join('\n'));

          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: (state is MyItemLoaded) ? state.filteredItems.length + 1 : 5,
            itemBuilder: (context, index) {
              if (state is MyItemLoading || state is MyItemInitial) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ShimmerProductListTile(height: 120),
                );
              }

              state as MyItemLoaded;

              if (index == state.filteredItems.length) return const SizedBox(height: 100);

              final Item item = state.filteredItems[index];

              return MyItemListTile(item: item);
            },
          );
        },
      ),
    );
  }
}
