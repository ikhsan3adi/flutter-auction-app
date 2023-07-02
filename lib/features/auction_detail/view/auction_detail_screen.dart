import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionDetailScreen extends StatelessWidget {
  const AuctionDetailScreen({super.key, required this.auction});

  final Auction auction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CoolAppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (scroll.metrics.axis != Axis.vertical) return false;
          if (scroll.metrics.pixels < 1000) {
            context.read<AppbarCubit>().scrolled(scroll.metrics.pixels);
            return true;
          }
          return false;
        },
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<AuctionDetailBloc>().add(AuctionDetailGetAuctionEvent(auction));
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColumnSuper(
                  innerDistance: -85,
                  children: const [
                    HeroProductImage(),
                    AuctionInformation(),
                  ],
                ),
                AuctionProductProperty(auction: auction),
                BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
                  builder: (context, state) {
                    if (state is AuctionDetailLoaded) {
                      final myBids = state.bidList.where((e) => e.mine).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          myBids.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SectionTitle(text: "My bid"),
                                    MyBid(bidList: myBids, auction: state.auction),
                                  ],
                                )
                              : const SizedBox(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionTitle(text: "Bidder list"),
                              state.bidList.isNotEmpty
                                  ? BidderList(bidList: state.bidList, auction: state.auction)
                                  : const SizedBox(height: 300, child: ErrorNoBid()),
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BidButton(auction: auction),
    );
  }
}
