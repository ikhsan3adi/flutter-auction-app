import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class BidList extends StatelessWidget {
  const BidList({super.key, required this.bids, required this.winAuction});

  final List<Bid> bids;
  final bool winAuction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Card(
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text("Your bids (${bids.length})", style: textTheme.titleSmall),
          children: bids.map((bid) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                backgroundImage: bid.profileImageUrl != null ? NetworkImage(bid.profileImageUrl!) : null,
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextHighlight(
                    code: winAuction ? 0 : 1,
                    child: Text(
                      "Rp${bid.bidPrice}",
                      style: textTheme.headlineSmall?.copyWith(color: ColorPalettes.highlightedText),
                    ),
                  ),
                ],
              ),
              subtitle: Text(DateFormat("dd MMMM yyyy").format(bid.createdAt).toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
