import 'dart:math';

import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/my_bid/bloc/my_bid_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class AuctionItemCard extends StatelessWidget {
  const AuctionItemCard({
    super.key,
    required this.auction,
    required this.winAuction,
    required this.bids,
  });

  final Auction auction;
  final List<Bid> bids;
  final bool winAuction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    final sortedBids = [...bids.map((e) => e.bidPrice)]..sort(max);

    final int highestBid = sortedBids.first;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 120,
        child: CustomInkWell(
          onTap: () {
            Navigator.pushNamed<bool?>(context, AuctionDetailPage.routeName, arguments: auction).then((value) {
              if ((value ?? false) && context.read<MyBidBloc>().state is MyBidLoaded) {
                context.read<MyBidBloc>().add(FetchMyBidAuction());
              }
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: auction.images.isNotEmpty
                    ? Image.network(
                        auction.images[0].url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const ErrorNoImage(message: 'Image error');
                        },
                      )
                    : const ErrorNoImage(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 0),
                      child: Text(
                        auction.itemName,
                        style: textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                      child: Text("Starts from: ", style: textTheme.bodySmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 0),
                      child: Text(
                        "Rp${auction.initialPrice}",
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 0),
                      child: Text("Your highest bid: ", style: textTheme.bodySmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 0),
                      child: Text(
                        "Rp$highestBid",
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                    child: TextHighlight(
                      code: auction.status == AuctionStatus.open ? 0 : 1,
                      child: Text(
                        auction.status.name,
                        style: textTheme.titleSmall?.copyWith(color: ColorPalettes.highlightedText),
                      ),
                    ),
                  ),
                  auction.status == AuctionStatus.open
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextHighlight(
                            code: winAuction ? 0 : 2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  winAuction ? Icons.flag_circle : Icons.mood_bad,
                                  color: ColorPalettes.highlightedText,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  winAuction ? "You Win!" : "You Lose :(",
                                  style: textTheme.titleSmall?.copyWith(
                                    color: ColorPalettes.highlightedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
