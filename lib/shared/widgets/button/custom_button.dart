import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.disabled = false,
    this.foregroundColor,
    this.backgroundColor,
  });

  final String text;
  final VoidCallback onPressed;

  final double? width;
  final double? height;

  final bool? disabled;

  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.width / 7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: disabled! ? theme.colorScheme.inverseSurface : (foregroundColor ?? theme.colorScheme.onPrimary),
          backgroundColor: disabled! ? theme.disabledColor : (backgroundColor ?? theme.colorScheme.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textTheme.headlineSmall?.copyWith(
            color: disabled! ? Colors.white70 : (foregroundColor ?? theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
