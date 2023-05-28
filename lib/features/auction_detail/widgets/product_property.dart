import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class AuctionProductProperty extends StatelessWidget {
  const AuctionProductProperty({super.key, required this.auction});

  final Auction auction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        tilePadding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        initiallyExpanded: true,
        title: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
          builder: (context, state) {
            if (state is AuctionDetailLoaded) {
              return Text(state.auction.itemName, style: textTheme.headlineMedium);
            } else if (state is AuctionDetailLoading) {
              return Text(auction.itemName, style: textTheme.headlineMedium);
            }

            return Text(
              "Error occurred",
              style: textTheme.headlineMedium?.copyWith(color: theme.colorScheme.error),
            );
          },
        ),
        children: [
          BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
            builder: (context, state) {
              TextTheme textTheme = Theme.of(context).textTheme;
              if (state is AuctionDetailLoaded) {
                DateTime dateCreated = state.auction.createdAt;
                DateTime? dateCompleted = state.auction.dateCompleted;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Description: \n${state.auction.description}", style: textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      Text(
                        "Date created: ${DateFormat("dd MMMM yyyy").format(dateCreated)}",
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        "Date completed: ${dateCompleted != null ? DateFormat("dd MMMM yyyy").format(dateCompleted) : '-'}",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              } else if (state is AuctionDetailLoading) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ShimmerItemDescription(),
                );
              }

              return Text(
                "Error occurred",
                style: textTheme.headlineMedium?.copyWith(color: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
