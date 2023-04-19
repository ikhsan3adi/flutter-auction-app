import 'package:auction_api/auction_api.dart';
import 'package:flutter/material.dart';

class ExploreListTile extends StatelessWidget {
  const ExploreListTile({super.key, required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 150,
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AspectRatio(
              aspectRatio: 1,
              child: Placeholder(),
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
                    padding: const EdgeInsets.fromLTRB(8, 6, 6, 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.people, size: 18),
                        const SizedBox(width: 5),
                        Text("3 Penawar", style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 6, 0),
                    child: Text("Mulai dari:", style: textTheme.bodySmall),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                    child: Text("Rp${item.initialPrice}", style: textTheme.headlineSmall),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
