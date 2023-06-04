import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/features/place_bid/place_bid.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class PlaceBidView extends StatefulWidget {
  const PlaceBidView({super.key});

  @override
  State<PlaceBidView> createState() => _PlaceBidViewState();
}

class _PlaceBidViewState extends State<PlaceBidView> {
  late final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Auction auction = (context.read<AuctionDetailBloc>().state as AuctionDetailLoaded).auction;

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Place bid",
            style: textTheme.headlineMedium,
          ),
          BlocBuilder<PlaceBidBloc, PlaceBidState>(
            builder: (context, state) {
              return state is PlaceBidFailed
                  ? Text(
                      state.message,
                      style: TextStyle(color: theme.colorScheme.error),
                    )
                  : const SizedBox();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: _formState,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: CustomTextFormField(
                        controller: _controller,
                        isNumberInput: true,
                        prefixText: 'Rp.',
                        helperText: 'Enter bid nominal',
                        hintText: '0',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Value cannot be empty";
                          } else if ((int.tryParse(value) ?? 0) < auction.initialPrice) {
                            return "Bid nominal can't be lower than the initial price";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: BlocConsumer<PlaceBidBloc, PlaceBidState>(
                    listener: (context, state) {
                      if (state is PlaceBidSuccess) Navigator.pop<bool>(context, true);
                    },
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          if (state is PlaceBidLoading) return;

                          if (_formState.currentState?.validate() ?? false) {
                            int? bidPrice = int.tryParse(_controller.text);

                            if (bidPrice == null) return;

                            context.read<PlaceBidBloc>().add(
                                  AttemptPlaceBid(
                                    auctionId: auction.id,
                                    bidPrice: bidPrice,
                                  ),
                                );
                          }
                        },
                        text: state is PlaceBidLoading ? 'Loading...' : 'Confirm',
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
