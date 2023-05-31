import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class MyAuctionScreen extends StatelessWidget {
  const MyAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    if (context.read<MyAuctionBloc>().state is MyAuctionInitial) {
      context.read<MyAuctionBloc>().add(FetchMyAuction());
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async => context.read<MyAuctionBloc>().add(FetchMyAuction()),
      child: SingleChildScrollView(
        child: BlocBuilder<MyAuctionBloc, MyAuctionState>(
          builder: (context, state) {
            if (state is MyAuctionError) return ErrorCommon(message: state.messages.join('\n'));

            return ListView.builder(
              shrinkWrap: true,
              itemCount: (state is MyAuctionLoaded) ? state.auctions.length : 5,
              itemBuilder: (context, index) {
                if (state is MyAuctionLoading || state is MyAuctionInitial) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ShimmerProductListTile(),
                  );
                }

                state as MyAuctionLoaded;

                final Auction auction = state.auctions[index];

                return SizedBox(
                  height: 150,
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
                                  child: Text(auction.itemName, style: textTheme.bodyMedium),
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
                                  child: Text("Rp${auction.initialPrice}", style: textTheme.headlineSmall),
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
                                  child: Text(
                                    "Created at: ${DateFormat('dd MMMM yyyy').format(auction.createdAt)}",
                                    style: textTheme.bodySmall,
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
              },
            );
          },
        ),
      ),
    );
  }
}
