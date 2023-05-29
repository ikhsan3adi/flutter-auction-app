import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({super.key, this.child, this.onTap});

  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: onTap),
          ),
        ),
      ],
    );
  }
}
