import 'dart:math';

import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class BidderList extends StatelessWidget {
  const BidderList({super.key, required this.bidList, required this.auction});

  final List<Bid> bidList;
  final Auction auction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    int highestBidPrice = bidList.map((e) => e.bidPrice).reduce(max);

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: bidList.length,
      itemBuilder: (context, index) {
        final Bid bid = bidList[index];

        // if (bid.mine) return null;

        Color priceBgColor = bid.bidPrice >= highestBidPrice
            ? ColorPalettes.highestBidBg
            : (bid.bidPrice < auction.initialPrice ? ColorPalettes.errBidBg : ColorPalettes.bidBg);

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            backgroundImage: bid.profileImageUrl != null ? NetworkImage(bid.profileImageUrl!) : null,
          ),
          title: Text("${bid.bidder?.username ?? 'Anonymous'}${bid.mine ? '(You)' : ''}", style: textTheme.headlineSmall),
          subtitle: Text(DateFormat("dd MMMM yyyy").format(bid.createdAt).toString(), style: textTheme.bodyLarge),
          trailing: Container(
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
        );
      },
    );
  }
}
