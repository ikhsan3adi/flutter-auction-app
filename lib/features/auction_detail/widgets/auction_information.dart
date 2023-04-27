import 'package:flutter/material.dart';

class AuctionInformation extends StatelessWidget {
  const AuctionInformation({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Rp500000",
                        style: textTheme.headlineMedium!.copyWith(color: Colors.black),
                      ),
                      Text("Starts from", style: textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: 50, child: VerticalDivider()),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Rp950000",
                        style: textTheme.headlineMedium!.copyWith(color: Colors.black),
                      ),
                      Text("Highest price", style: textTheme.bodyLarge),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              child: Text("Ends in: 4 Day 2 Hour", style: textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
