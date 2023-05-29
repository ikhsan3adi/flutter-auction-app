import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class AuctionItemCard extends StatelessWidget {
  const AuctionItemCard({
    super.key,
    required this.auction,
    required this.bidCount,
    required this.winAuction,
  });

  final Auction auction;
  final int bidCount;
  final bool winAuction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 120,
        child: CustomInkWell(
          onTap: () => Navigator.pushNamed(context, AuctionDetailPage.routeName, arguments: auction),
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
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                      child: Text(
                        auction.itemName,
                        style: textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.price_change, size: 18),
                          const SizedBox(width: 5),
                          Text("Your bid count: $bidCount", style: textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                      child: TextHighlight(
                        code: auction.status == AuctionStatus.open ? 0 : 1,
                        child: Text(
                          "Status: ${auction.status.name}",
                          style: textTheme.bodyMedium?.copyWith(color: ColorPalettes.highlightedText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                      child: Text("Starts from: ", style: textTheme.bodySmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 0),
                      child: Text("Rp${auction.initialPrice}", style: textTheme.headlineSmall),
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
                                    style: textTheme.headlineSmall?.copyWith(
                                      color: ColorPalettes.highlightedText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
