import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBasic extends StatelessWidget {
  const ShimmerBasic({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorPalettes.shimmerBg,
      highlightColor: ColorPalettes.shimmer,
      child: child ?? Container(color: ColorPalettes.shimmerBg),
    );
  }
}
