import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required TextEditingController controller,
    this.validator,
    this.helperText,
    this.prefixText,
    this.hintText,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String? Function(String?)? validator;
  final String? helperText, prefixText, hintText;

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

    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        border: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.disabledColor)),
        errorBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.error)),
        focusedBorder: inputBorder.copyWith(borderSide: borderSide.copyWith(color: theme.colorScheme.primary)),
        focusedErrorBorder: inputBorder,
        prefixText: prefixText,
        helperText: helperText,
        hintText: hintText,
        counterText: ' ',
      ),
      validator: validator,
    );
  }
}
