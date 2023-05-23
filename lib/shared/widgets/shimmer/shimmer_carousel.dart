import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCarousel extends StatelessWidget {
  const ShimmerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 6 / 4,
          child: Shimmer.fromColors(
            baseColor: ColorPalettes.shimmerBg,
            highlightColor: ColorPalettes.shimmer,
            child: Container(color: ColorPalettes.shimmerBg),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Shimmer.fromColors(
              baseColor: ColorPalettes.shimmerBg,
              highlightColor: ColorPalettes.shimmer,
              direction: ShimmerDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    color: ColorPalettes.shimmerBg,
                    width: MediaQuery.of(context).size.width / 7,
                    child: Text('', style: textTheme.titleMedium!),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    color: ColorPalettes.shimmerBg,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text('', style: textTheme.headlineMedium!),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
