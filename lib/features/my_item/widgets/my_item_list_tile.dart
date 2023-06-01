import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class MyItemListTile extends StatelessWidget {
  const MyItemListTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SizedBox(
        height: 120,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Expanded(
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
                              child: Text(
                                item.itemName,
                                style: textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                              child: Text("Initial price:", style: textTheme.bodySmall),
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
              const VerticalDivider(),
              IconButton(
                padding: const EdgeInsets.all(16),
                onPressed: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmDialog(),
                  ).then((delete) {
                    if (delete ?? false) {
                      Fluttertoast.showToast(msg: 'Deleting bid...');
                      context.read<MyItemBloc>().add(DeleteItem(item: item));
                    }
                  });
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
