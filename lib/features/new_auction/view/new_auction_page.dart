import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_auction/new_auction.dart';
import 'package:flutter_online_auction_app/shared/widgets/appbar.dart';

class NewAuctionPage extends StatelessWidget {
  /// '/new_auction'
  static const String routeName = '/new_auction';

  const NewAuctionPage({super.key});

  static Route<bool?> route() {
    return MaterialPageRoute<bool?>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NewAuctionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuctionRepository auctionRepository = context.read<AuctionRepository>();
    final ItemRepository itemRepository = context.read<ItemRepository>();
    final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

    return Scaffold(
      appBar: const MyCustomAppbar(title: 'New Auction'),
      body: BlocProvider(
        create: (context) => NewAuctionBloc(
          auctionRepository: auctionRepository,
          itemRepository: itemRepository,
          authenticationRepository: authenticationRepository,
        )..add(FetchAuctionItems()),
        child: const NewAuctionScreen(),
      ),
    );
  }
}
