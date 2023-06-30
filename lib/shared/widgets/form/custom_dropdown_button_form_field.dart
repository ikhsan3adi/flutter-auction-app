import 'package:flutter/material.dart';

class CustomDropdownButtonField<T> extends StatelessWidget {
  const CustomDropdownButtonField({
    super.key,
    required this.items,
    required this.value,
    this.validator,
    this.onTap,
    this.helperText,
    this.prefixText,
    this.hintText,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.itemHeight,
    this.style,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;

  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final VoidCallback? onTap;
  final String? helperText, prefixText, hintText, errorText;

  final TextStyle? style;
  final double? itemHeight;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final BorderSide borderSide = BorderSide(
      width: 3,
      strokeAlign: BorderSide.strokeAlignCenter,
      color: theme.colorScheme.onSurface,
    );

    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: borderSide,
    );

    return DropdownButtonFormField<T>(
      itemHeight: itemHeight,
      isExpanded: true,
      items: items,
      value: value,
      onChanged: onChanged,
      onTap: onTap,
      icon: const Icon(Icons.keyboard_arrow_down),
      style: style,
      decoration: InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.disabledColor)),
        errorBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.error)),
        focusedBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.primary)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
        focusedErrorBorder: inputBorder,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        helperText: helperText,
        hintText: hintText,
        errorText: errorText,
        counterText: ' ',
      ),
      validator: validator,
    );
  }
}
