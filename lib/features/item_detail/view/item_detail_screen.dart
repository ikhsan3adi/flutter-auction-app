import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/item_detail/item_detail.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemDetailBloc, ItemDetailState>(
      listener: (_, state) {
        if (state is ItemDetailDeleted) Navigator.of(context).pop();
      },
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          if (context.read<ItemDetailBloc>().state is ItemDetailLoaded) {
            context.read<ItemDetailBloc>().add(ItemDetailGetItemEvent(item));
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselImage(item: item),
              _ItemName(item: item),
              const _ItemPrice(),
              const _ItemDescription(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  const _ItemName({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: BlocBuilder<ItemDetailBloc, ItemDetailState>(
        builder: (context, state) {
          return state is ItemDetailLoaded
              ? Text(state.item.itemName, style: textTheme.headlineMedium)
              : Text(item.itemName, style: textTheme.headlineMedium);
        },
      ),
    );
  }
}

class _ItemPrice extends StatelessWidget {
  const _ItemPrice();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<ItemDetailBloc, ItemDetailState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Initial Price:", style: textTheme.bodyLarge),
              Text(
                state is ItemDetailLoaded ? "Rp${state.item.initialPrice}" : "N/A",
                style: textTheme.headlineMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  const _ItemDescription();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: BlocBuilder<ItemDetailBloc, ItemDetailState>(
        builder: (context, state) {
          return state is ItemDetailLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Description: \n${state.item.description}", style: textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    Text(
                      "Date created: ${DateFormat("dd MMMM yyyy").format(state.item.createdAt)}",
                      style: textTheme.bodyMedium,
                    ),
                  ],
                )
              : const ShimmerItemDescription();
        },
      ),
    );
  }
}
