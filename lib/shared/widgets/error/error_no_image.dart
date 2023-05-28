import 'package:flutter/material.dart';

class ErrorNoImage extends StatelessWidget {
  const ErrorNoImage({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.errorContainer,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber,
              color: theme.colorScheme.error,
              size: MediaQuery.of(context).size.width / 8,
            ),
            Text(
              message ?? "No image",
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
