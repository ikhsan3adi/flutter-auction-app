import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/bloc/auction_detail_bloc.dart';
import 'package:flutter_online_auction_app/features/place_bid/place_bid.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BidButton extends StatelessWidget {
  const BidButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocBuilder<AuctionDetailBloc, AuctionDetailState>(
              builder: (context, state) {
                return CustomButton(
                  text: state is AuctionDetailLoading ? "Loading..." : "Place bid",
                  onPressed: () {
                    if (state is AuctionDetailLoaded) {
                      final BidRepository bidRepository = context.read<BidRepository>();
                      final AuthenticationRepository authenticationRepository = context.read<AuthenticationRepository>();

                      showModalBottomSheet<bool>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => PlaceBidBloc(
                                bidRepository: bidRepository,
                                authenticationRepository: authenticationRepository,
                              ),
                            ),
                            BlocProvider.value(value: context.read<AuctionDetailBloc>()),
                          ],
                          child: const PlaceBidView(),
                        ),
                      ).then((changed) {
                        if (changed ?? false) {
                          Fluttertoast.showToast(msg: 'Place bid successful');
                          context.read<AuctionDetailBloc>().add(AuctionDetailGetAuctionEvent(state.auction));
                        }
                      });
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
