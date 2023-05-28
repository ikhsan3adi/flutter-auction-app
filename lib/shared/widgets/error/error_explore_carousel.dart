import 'package:flutter/material.dart';

class ErrorExploreCarousel extends StatelessWidget {
  const ErrorExploreCarousel({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 6 / 4,
      child: Container(
        color: theme.colorScheme.errorContainer,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber,
                color: theme.colorScheme.error,
                size: MediaQuery.of(context).size.width / 5,
              ),
              Text(
                "Error occured!",
                style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
              Text(
                message,
                style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
