import 'package:flutter/material.dart';

class ErrorNoBid extends StatelessWidget {
  const ErrorNoBid({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.close,
                color: theme.disabledColor,
                size: MediaQuery.of(context).size.width / 8,
              ),
              Text(
                "No bids yet",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
