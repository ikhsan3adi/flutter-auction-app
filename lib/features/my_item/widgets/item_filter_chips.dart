import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';

class ItemFilterChips extends StatelessWidget implements PreferredSizeWidget {
  const ItemFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: BlocBuilder<MyItemBloc, MyItemState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyItemLoaded) ? state.filter == ItemFilter.all : false,
                        label: Text(ItemFilter.all.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyItemBloc>().add(const FilterMyItem(filter: ItemFilter.all)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyItemLoaded) ? state.filter == ItemFilter.auctioned : false,
                        label: Text(ItemFilter.auctioned.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyItemBloc>().add(const FilterMyItem(filter: ItemFilter.auctioned)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyItemLoaded) ? state.filter == ItemFilter.inactive : false,
                        label: Text(ItemFilter.inactive.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyItemBloc>().add(const FilterMyItem(filter: ItemFilter.inactive)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
