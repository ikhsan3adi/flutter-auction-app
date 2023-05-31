import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:intl/intl.dart';

class MyItemScreen extends StatelessWidget {
  const MyItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    if (context.read<MyItemBloc>().state is MyItemInitial) {
      context.read<MyItemBloc>().add(FetchMyItem());
    }

    return RefreshIndicator.adaptive(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: BlocBuilder<MyItemBloc, MyItemState>(
          builder: (context, state) {
            if (state is MyItemError) return ErrorCommon(message: state.messages.join('\n'));

            return ListView.builder(
              shrinkWrap: true,
              itemCount: (state is MyItemLoaded) ? state.items.length : 5,
              itemBuilder: (context, index) {
                if (state is MyItemLoading || state is MyItemInitial) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ShimmerProductListTile(),
                  );
                }

                state as MyItemLoaded;

                final Item item = state.items[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SizedBox(
                    height: 120,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: CustomInkWell(
                        onTap: () {/** TODO: goto item detail page */},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: item.images.isNotEmpty
                                  ? Image.network(
                                      item.images[0].url,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const ErrorNoImage(message: 'Image error');
                                      },
                                    )
                                  : const ErrorNoImage(),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                                    child: Text(item.itemName, style: textTheme.bodyMedium),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                                    child: Text("Starts from:", style: textTheme.bodySmall),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                                    child: Text("Rp${item.initialPrice}", style: textTheme.headlineSmall),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                                    child: Text(DateFormat("dd MMMM yyyy").format(item.createdAt), style: textTheme.bodySmall),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
