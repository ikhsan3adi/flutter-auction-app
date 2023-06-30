import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/explore/explore.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 5 / 8,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: item.images.isNotEmpty
                    ? Image.network(
                        item.images[0].url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const ErrorNoImage(message: 'Image error'),
                      )
                    : const ErrorNoImage(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 4, 6, 5),
                child: Text(item.itemName, style: textTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                child: Text("Starts from:", style: textTheme.bodySmall),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 2),
                child: Text("Rp${item.initialPrice}", style: textTheme.headlineSmall),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
                child: Row(
                  children: [
                    const Icon(Icons.people, size: 18),
                    const SizedBox(width: 5),
                    Text("${item.bidCount ?? 0} Bidder", style: textTheme.bodyMedium),
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
