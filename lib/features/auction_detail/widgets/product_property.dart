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
              "Sepertinya terdapat masalah :(",
              style: textTheme.headlineMedium?.copyWith(color: Colors.red),
            );
          },
        ),
        children: [
          BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
            builder: (context, state) {
              TextTheme textTheme = Theme.of(context).textTheme;
              if (state is AuctionDetailLoaded) {
                DateTime waktuMulai = state.auction.dateCreated;
                DateTime waktuSelesai = state.auction.dateCompleted;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Deskripsi: ${state.auction.description}", style: textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      Text(
                        "Tanggal dibuat: ${DateFormat("dd MMMM yyyy").format(waktuMulai)}",
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        "Tanggal berakhir: ${DateFormat("dd MMMM yyyy").format(waktuSelesai)}",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              } else if (state is AuctionDetailLoading) {
                return const CircularProgressIndicator.adaptive();
              }

              return Text(
                "Sepertinya terdapat masalah :(",
                style: textTheme.headlineMedium?.copyWith(color: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
