import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AuctionProductProperty extends StatelessWidget {
  const AuctionProductProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        initiallyExpanded: true,
        title: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
          builder: (context, state) {
            TextTheme textTheme = Theme.of(context).textTheme;
            if (state is AuctionDetailLoaded) {
              return Text(state.auction.itemName, style: textTheme.headlineMedium?.copyWith(color: Colors.black87));
            } else if (state is AuctionDetailLoading) {
              return const CircularProgressIndicator.adaptive();
            }

            return Text(
              "Error occurred",
              style: textTheme.headlineMedium?.copyWith(color: Colors.red),
            );
          },
        ),
        children: [
          BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
            builder: (context, state) {
              TextTheme textTheme = Theme.of(context).textTheme;
              if (state is AuctionDetailLoaded) {
                DateTime dateCreated = state.auction.createdAt;
                DateTime dateCompleted = state.auction.dateCompleted;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Description: ${state.auction.description}", style: textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      Text(
                        "Date created: ${DateFormat("dd MMMM yyyy").format(dateCreated)}",
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        "Date completed: ${DateFormat("dd MMMM yyyy").format(dateCompleted)}",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              } else if (state is AuctionDetailLoading) {
                return const CircularProgressIndicator.adaptive();
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
