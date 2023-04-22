import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionDetailScreen extends StatelessWidget {
  const AuctionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CoolAppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (scroll.metrics.axis != Axis.vertical) return false;
          if (scroll.metrics.pixels < 1000) {
            context.read<AppbarCubit>().scrolled(scroll.metrics.pixels);
            return true;
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnSuper(
                innerDistance: -85,
                children: const [
                  HeroProductImage(),
                  AuctionInformation(),
                ],
              ),
              const AuctionProductProperty(),
              const SectionTitle(text: "Penawaran saya"),
              const MyBid(),
              const SectionTitle(text: "Daftar penawar"),
              const BidderList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BidButton(),
    );
  }
}
