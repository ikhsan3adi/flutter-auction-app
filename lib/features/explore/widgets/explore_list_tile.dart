import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class ExploreListTile extends StatelessWidget {
  const ExploreListTile({super.key, required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 150,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: CustomInkWell(
          onTap: () {
            Navigator.pushNamed<bool?>(context, AuctionDetailPage.routeName, arguments: item).then((value) {
              if ((value ?? false) && context.read<ExploreBloc>().state is ExploreLoaded) {
                context.read<ExploreBloc>().add(ExploreFetchAuctionEvent());
              }
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: item.images.isNotEmpty
                    ? Image.network(
                        item.images[0].url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const ErrorNoImage(message: 'Image error');
                        },
                      )
                    : const ErrorNoImage(),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                      child: Text(item.itemName, style: textTheme.bodyMedium),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.people, size: 18),
                          const SizedBox(width: 5),
                          Text("${item.bidCount ?? 0} Bidder", style: textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                      child: Text("Starts from:", style: textTheme.bodySmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                      child: Text("Rp${item.initialPrice}", style: textTheme.headlineSmall),
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
