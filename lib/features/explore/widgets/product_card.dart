import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});

  final Auction item;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AspectRatio(
              aspectRatio: 1,
              child: Placeholder(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 5),
              child: Text(item.itemName, style: textTheme.bodyMedium),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: Text("Mulai dari:", style: textTheme.bodySmall),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 2),
              child: Text("Rp${item.initialPrice}", style: textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
              child: Row(
                children: [
                  const Icon(Icons.people, size: 18),
                  const SizedBox(width: 5),
                  Text("3 Penawar", style: textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
