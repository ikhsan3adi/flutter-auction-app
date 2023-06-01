import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyAuctionScreen extends StatelessWidget {
  const MyAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<MyAuctionBloc>().state is MyAuctionInitial) {
      context.read<MyAuctionBloc>().add(FetchMyAuction());
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async => context.read<MyAuctionBloc>().add(FetchMyAuction()),
      child: BlocBuilder<MyAuctionBloc, MyAuctionState>(
        builder: (context, state) {
          if (state is MyAuctionError) return ErrorCommon(message: state.messages.join('\n'));

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (state is MyAuctionLoaded) ? state.filteredAuctions.length + 1 : 5,
            itemBuilder: (context, index) {
              if (state is MyAuctionLoading || state is MyAuctionInitial) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ShimmerProductListTile(height: 120),
                );
              }

              state as MyAuctionLoaded;

              if (index == state.filteredAuctions.length) return const SizedBox(height: 100);

              final Auction auction = state.filteredAuctions[index];

              return MyAuctionListTile(auction: auction);
            },
          );
        },
      ),
    );
  }
}
