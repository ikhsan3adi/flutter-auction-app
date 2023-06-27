import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class MyBidScreen extends StatelessWidget {
  const MyBidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    if (context.read<MyBidBloc>().state is MyBidInitial) {
      context.read<MyBidBloc>().add(FetchMyBidAuction());
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<MyBidBloc>().add(FetchMyBidAuction());
      },
      child: BlocBuilder<MyBidBloc, MyBidState>(
        builder: (context, state) {
          if (state is MyBidError) return ErrorCommon(message: state.messages.join('\n'));

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (state is MyBidLoaded) ? (state.filteredAuctions.isEmpty ? 1 : state.filteredAuctions.length) : 5,
            itemBuilder: (context, index) {
              if (state is MyBidLoading || state is MyBidInitial) {
                return _myBidShimmerLoading();
              }

              state as MyBidLoaded;

              if (state.filteredAuctions.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const Center(child: ErrorNoBid()),
                );
              }

              final auction = state.filteredAuctions[index].auction;
              final bids = state.filteredAuctions[index].bids;

              final bool winAuction = auction.status == AuctionStatus.closed
                  ? (auction.winner?.username == context.read<TokenRepository>().token?.userData?.username)
                  : false;

              return Card(
                color: theme.colorScheme.secondaryContainer,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuctionItemCard(
                      auction: auction,
                      winAuction: winAuction,
                      bids: bids,
                    ),
                    BidList(bids: bids, winAuction: winAuction),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _myBidShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ShimmerProductListTile(height: 120),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Shimmer.fromColors(
              baseColor: ColorPalettes.shimmerBg,
              highlightColor: ColorPalettes.shimmer,
              child: Container(
                color: ColorPalettes.shimmerBg,
                child: const ListTile(title: Text("")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
