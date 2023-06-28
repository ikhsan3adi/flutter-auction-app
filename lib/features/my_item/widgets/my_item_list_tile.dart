import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/item_detail/view/views.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomInkWell(
                  onTap: () => Navigator.of(context).pushNamed(ItemDetailPage.routeName, arguments: item),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 6, 0),
                    child: TextHighlight(
                      code: item.auctioned ? 0 : 1,
                      child: Text(
                        item.auctioned ? ItemFilter.auctioned.name : ItemFilter.inactive.name,
                        style: textTheme.titleSmall?.copyWith(
                          color: ColorPalettes.highlightedText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 60,
                        child: VerticalDivider(),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(16),
                        onPressed: () async {
                          Fluttertoast.cancel();
                          if (item.auctioned) {
                            Fluttertoast.showToast(msg: "Auctioned item can't be deleted");
                          } else {
                            await showDialog<bool>(
                              context: context,
                              builder: (context) => const ConfirmDialog(),
                            ).then((delete) {
                              if (delete ?? false) {
                                Fluttertoast.showToast(msg: 'Deleting bid...');
                                context.read<MyItemBloc>().add(DeleteItem(item: item));
                              }
                            });
                          }
                        },
                        tooltip: "Delete",
                        icon: Icon(
                          Icons.delete_forever,
                          color: item.auctioned ? theme.disabledColor : theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
