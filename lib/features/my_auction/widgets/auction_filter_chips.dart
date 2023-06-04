import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';

class AuctionFilterChips extends StatelessWidget implements PreferredSizeWidget {
  const AuctionFilterChips({super.key});

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
            child: BlocBuilder<MyAuctionBloc, MyAuctionState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyAuctionLoaded) ? state.filter == AuctionFilter.all : false,
                        label: Text(AuctionFilter.all.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyAuctionBloc>().add(const FilterMyAuction(filter: AuctionFilter.all)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyAuctionLoaded) ? state.filter == AuctionFilter.open : false,
                        label: Text(AuctionFilter.open.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyAuctionBloc>().add(const FilterMyAuction(filter: AuctionFilter.open)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        selected: (state is MyAuctionLoaded) ? state.filter == AuctionFilter.closed : false,
                        label: Text(AuctionFilter.closed.name, style: textTheme.bodySmall),
                        onSelected: (value) => context.read<MyAuctionBloc>().add(const FilterMyAuction(filter: AuctionFilter.closed)),
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
