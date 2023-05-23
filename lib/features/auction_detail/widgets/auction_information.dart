import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/bloc/auction_detail_bloc.dart';

class AuctionInformation extends StatelessWidget {
  const AuctionInformation({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.3,
          child: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
            builder: (context, state) {
              if (state is AuctionDetailLoading) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }

              String highestBid;

              if (state is AuctionDetailLoaded) {
                highestBid = state.bidList.isNotEmpty ? "Rp${state.bidList.map((e) => e.bidPrice).reduce(max)}" : "Rp${state.auction.initialPrice}";
              } else {
                highestBid = "N/A";
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state is AuctionDetailLoaded ? "Rp${state.auction.initialPrice}" : "N/A",
                              style: textTheme.headlineMedium,
                            ),
                            Text("Starts from", style: textTheme.bodyLarge),
                          ],
                        ),
                        const SizedBox(height: 50, child: VerticalDivider()),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              highestBid,
                              style: textTheme.headlineMedium,
                            ),
                            Text("Highest price", style: textTheme.bodyLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14, right: 8, left: 8),
                    child: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
                      builder: (context, state) {
                        if (state is AuctionDetailLoaded) {
                          if (state.auction.dateCompleted != null) {
                            Duration difference = state.auction.dateCompleted!.difference(DateTime.now());

                            String remaining = difference.inHours <= 24
                                ? "${difference.inHours} Hours"
                                : "${difference.inDays} Days ${difference.inHours % 24} Hours";

                            return Text("Ends in: $remaining", style: textTheme.bodyLarge);
                          }
                        }
                        return Text("Ends in: N/A", style: textTheme.bodyLarge);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
