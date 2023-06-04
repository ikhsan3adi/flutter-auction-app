import 'package:flutter/material.dart';

class FormFieldTitle extends StatelessWidget {
  const FormFieldTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12, left: 20),
      child: Text(text, style: textTheme.headlineSmall),
    );
  }
}
