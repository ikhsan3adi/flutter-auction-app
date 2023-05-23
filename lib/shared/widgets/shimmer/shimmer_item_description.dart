import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemDescription extends StatelessWidget {
  const ShimmerItemDescription({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Shimmer.fromColors(
      baseColor: ColorPalettes.shimmerBg,
      highlightColor: ColorPalettes.shimmer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width * 0.3,
            color: ColorPalettes.shimmerBg,
            child: Text('', style: textTheme.bodySmall),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width,
            color: ColorPalettes.shimmerBg,
            child: Text('', style: textTheme.bodySmall),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width * 0.8,
            color: ColorPalettes.shimmerBg,
            child: Text('', style: textTheme.bodySmall),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width * 0.9,
            color: ColorPalettes.shimmerBg,
            child: Text('', style: textTheme.bodySmall),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            width: MediaQuery.of(context).size.width * 0.5,
            color: ColorPalettes.shimmerBg,
            child: Text('', style: textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
