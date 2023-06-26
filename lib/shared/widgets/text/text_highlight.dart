import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/shared/theme/theme.dart';

/// [code]
/// 0 = green
/// 1 = amber
/// 2 = red
class TextHighlight extends StatelessWidget {
  const TextHighlight({super.key, this.child, this.code});

  final Widget? child;
  final int? code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: _getColor(code ?? 0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Color _getColor(int code) {
    switch (code) {
      case 0:
        return ColorPalettes.greenHighlight;
      case 1:
        return ColorPalettes.amberHighlight;
      case 2:
        return ColorPalettes.redHighlight;
      default:
        return ColorPalettes.amberHighlight;
    }
  }
}
