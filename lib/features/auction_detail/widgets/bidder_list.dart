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

    final List<Bid> sortedBids = bidList
      ..sort((a, b) {
        if (auction.winner == null) return 0;
        return (b.bidder?.username == auction.winner?.username) ? -1 : 1;
      })
      ..sort((a, b) => b.bidPrice.compareTo(a.bidPrice));

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: bidList.length,
      itemBuilder: (context, index) {
        final Bid bid = sortedBids[index];

        bool isWinner = bid.bidder?.username == auction.winner?.username;
        String title = "${bid.bidder?.username ?? 'Anonymous'}${bid.mine ? '\n(You)' : ''}${isWinner ? '\n(Winner)' : ''}";
        int colorCode = bid.bidPrice >= highestBidPrice ? 0 : (bid.bidPrice < auction.initialPrice ? 2 : 1);

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            backgroundImage: bid.profileImageUrl != null ? NetworkImage(bid.profileImageUrl!) : null,
          ),
          title: Text(title, style: textTheme.headlineSmall),
          subtitle: Text(DateFormat("dd MMMM yyyy").format(bid.createdAt).toString(), style: textTheme.bodyMedium),
          trailing: TextHighlight(
            code: colorCode,
            child: Text(
              "Rp${bid.bidPrice}",
              style: textTheme.headlineSmall?.copyWith(color: ColorPalettes.highlightedText),
            ),
          ),
        );
      },
    );
  }
}
