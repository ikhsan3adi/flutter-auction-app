import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Shimmer.fromColors(
                baseColor: ColorPalettes.shimmerBg,
                highlightColor: ColorPalettes.shimmer,
                child: Container(color: ColorPalettes.shimmerBg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 5),
              child: Container(
                color: ColorPalettes.shimmerBg,
                width: MediaQuery.of(context).size.width / 3,
                height: 16,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 2),
              child: Container(
                color: ColorPalettes.shimmerBg,
                width: MediaQuery.of(context).size.width / 4,
                height: 24,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
