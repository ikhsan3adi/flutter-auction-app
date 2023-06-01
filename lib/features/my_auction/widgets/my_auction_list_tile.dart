import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyAuctionListTile extends StatelessWidget {
  const MyAuctionListTile({super.key, required this.auction});

  final Auction auction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SizedBox(
        height: 120,
        child: Card(
          clipBehavior: Clip.hardEdge,
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
                            const Icon(Icons.people, size: 18),
                            const SizedBox(width: 5),
                            Text("${auction.bidCount ?? 0} Bidder", style: textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                        child: Text("Starts from:", style: textTheme.bodySmall),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                        child: Text(
                          "Rp${auction.initialPrice}",
                          style: textTheme.headlineSmall,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 6, 0),
                      child: TextHighlight(
                        code: auction.status == AuctionStatus.open ? 0 : 1,
                        child: Text(
                          auction.status.name,
                          style: textTheme.titleSmall?.copyWith(
                            color: ColorPalettes.highlightedText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
