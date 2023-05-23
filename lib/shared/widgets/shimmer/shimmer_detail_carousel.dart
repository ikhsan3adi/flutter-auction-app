import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/auction_detail/auction_detail.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailCarousel extends StatelessWidget {
  const ShimmerDetailCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: ColorPalettes.shimmerBg.withAlpha(120)),
          Padding(
            padding: EdgeInsets.only(top: 75, bottom: AuctionDetailConstant.bottomImageMargin),
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Shimmer.fromColors(
                    baseColor: ColorPalettes.shimmerBg,
                    highlightColor: ColorPalettes.shimmer,
                    child: Container(color: ColorPalettes.shimmerBg),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
