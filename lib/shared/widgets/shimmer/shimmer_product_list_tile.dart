import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductListTile extends StatelessWidget {
  const ShimmerProductListTile({super.key, this.height = 150});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Shimmer.fromColors(
                baseColor: ColorPalettes.shimmerBg,
                highlightColor: ColorPalettes.shimmer,
                child: Container(color: ColorPalettes.shimmerBg),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 6, 5),
                    child: Shimmer.fromColors(
                      baseColor: ColorPalettes.shimmerBg,
                      highlightColor: ColorPalettes.shimmer,
                      child: Container(
                        color: ColorPalettes.shimmerBg,
                        height: 20,
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 54),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 6, 2),
                    child: Shimmer.fromColors(
                      baseColor: ColorPalettes.shimmerBg,
                      highlightColor: ColorPalettes.shimmer,
                      child: Container(
                        color: ColorPalettes.shimmerBg,
                        height: 24,
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                    ),
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
