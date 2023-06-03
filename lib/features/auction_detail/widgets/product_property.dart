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
      child: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
        builder: (context, state) {
          if (state is! AuctionDetailError) {
            DateTime? dateCreated;
            DateTime? dateCompleted;

            if (state is AuctionDetailLoaded) {
              dateCreated = state.auction.createdAt;
              dateCompleted = state.auction.dateCompleted;
            }

            return ExpansionTile(
              expandedAlignment: Alignment.topLeft,
              tilePadding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              initiallyExpanded: true,
              title: state is AuctionDetailLoaded
                  ? Text(state.auction.itemName, style: textTheme.headlineMedium)
                  : Text(auction.itemName, style: textTheme.headlineMedium),
              children: [
                BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
                  builder: (context, state) {
                    return state is AuctionDetailLoaded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Description: \n${state.auction.description}", style: textTheme.bodyMedium),
                                const SizedBox(height: 20),
                                Text(
                                  "Date created: ${DateFormat("dd MMMM yyyy").format(dateCreated!)}",
                                  style: textTheme.bodyMedium,
                                ),
                                Text(
                                  "Date completed: ${dateCompleted != null ? DateFormat("dd MMMM yyyy").format(dateCompleted) : '-'}",
                                  style: textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: ShimmerItemDescription(),
                          );
                  },
                ),
              ],
            );
          } else {
            return ErrorCommon(message: state.messages[0]);
          }
        },
      ),
    );
  }
}
