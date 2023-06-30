import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/features/new_auction/new_auction.dart';

class MyAuctionPage extends StatelessWidget {
  /// '/my_auction'
  static const String routeName = '/my_auction';

  const MyAuctionPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MyAuctionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      appBar: const AuctionFilterChips(),
      body: const MyAuctionScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed<bool?>(context, NewAuctionPage.routeName).then((value) {
            if ((value ?? false) && context.read<MyAuctionBloc>().state is MyAuctionLoaded) {
              context.read<MyAuctionBloc>().add(FetchMyAuction());
            }
          });
        },
        label: Text("New Auction", style: textTheme.titleMedium),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
