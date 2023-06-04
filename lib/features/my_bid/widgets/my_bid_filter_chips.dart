import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';

class MyBidFilterChips extends StatelessWidget implements PreferredSizeWidget {
  const MyBidFilterChips({super.key});

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
            child: BlocBuilder<MyBidBloc, MyBidState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            selected: (state is MyBidLoaded) ? state.filter == MyBidFilter.all : false,
                            label: Text(MyBidFilter.all.name, style: textTheme.bodySmall),
                            onSelected: (value) => context.read<MyBidBloc>().add(const FilterMyBid(filter: MyBidFilter.all)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            selected: (state is MyBidLoaded) ? state.filter == MyBidFilter.ongoing : false,
                            label: Text(MyBidFilter.ongoing.name, style: textTheme.bodySmall),
                            onSelected: (value) => context.read<MyBidBloc>().add(const FilterMyBid(filter: MyBidFilter.ongoing)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            selected: (state is MyBidLoaded) ? state.filter == MyBidFilter.win : false,
                            label: Text(MyBidFilter.win.name, style: textTheme.bodySmall),
                            onSelected: (value) => context.read<MyBidBloc>().add(const FilterMyBid(filter: MyBidFilter.win)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            selected: (state is MyBidLoaded) ? state.filter == MyBidFilter.lose : false,
                            label: Text(MyBidFilter.lose.name, style: textTheme.bodySmall),
                            onSelected: (value) => context.read<MyBidBloc>().add(const FilterMyBid(filter: MyBidFilter.lose)),
                          ),
                        ),
                      ],
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
