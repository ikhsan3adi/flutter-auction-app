import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/bloc/auction_detail_bloc.dart';
import 'package:flutter_online_auction_app/features/place_bid/place_bid.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BidButton extends StatelessWidget {
  const BidButton({super.key, required this.auction});

  final Auction auction;

  @override
  Widget build(BuildContext context) {
    final Token? token = context.read<TokenRepository>().token;
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocConsumer<AuctionDetailBloc, AuctionDetailState>(
              listener: (_, state) {
                if (state is AuctionDeleted) {
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(msg: 'Auction deleted');
                  Navigator.of(context).pop(true);
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: state is AuctionDetailLoading ? "Loading..." : "Place bid",
                        disabled: auction.author.username == token?.userData?.username,
                        onPressed: () {
                          if (auction.author.username == token?.userData?.username) return;

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
                      ),
                    ),
                    auction.author.username == token?.userData?.username ? const SizedBox(width: 8) : const SizedBox(),
                    auction.author.username == token?.userData?.username
                        ? Expanded(
                            child: CustomButton(
                              backgroundColor: theme.colorScheme.error,
                              onPressed: () async {
                                await showDialog<bool>(
                                  context: context,
                                  builder: (context) => const ConfirmDialog(),
                                ).then((delete) {
                                  if (delete ?? false) {
                                    Fluttertoast.showToast(msg: 'Deleting auction...');
                                    context.read<AuctionDetailBloc>().add(AuctionDetailDeleteAuction());
                                  }
                                });
                              },
                              text: "Delete",
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
