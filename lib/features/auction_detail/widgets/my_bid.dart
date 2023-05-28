import 'dart:math';

import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class MyBid extends StatelessWidget {
  const MyBid({super.key, required this.bidList, required this.auction});

  final List<Bid> bidList;
  final Auction auction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    int highestBidPrice = bidList.map((e) => e.bidPrice).reduce(max);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
          children: bidList.where((e) => e.mine).map((bid) {
        Color priceBgColor = bid.bidPrice >= highestBidPrice
            ? ColorPalettes.highestBidBg
            : (bid.bidPrice < auction.initialPrice ? ColorPalettes.errBidBg : ColorPalettes.bidBg);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 2, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colorScheme.primary,
                        backgroundImage: bid.bidder?.profileImageUrl != null ? NetworkImage(bid.bidder!.profileImageUrl!) : null,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: priceBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Rp${bid.bidPrice}",
                            style: textTheme.headlineSmall?.copyWith(color: Colors.blue.shade900),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(DateFormat("dd MMMM yyyy").format(bid.createdAt), style: textTheme.bodyMedium),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }).toList()),
    );
  }
}
