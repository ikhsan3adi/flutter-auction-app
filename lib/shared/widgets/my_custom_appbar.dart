import 'package:flutter/material.dart';

class MyCustomAppbar extends StatelessWidget with PreferredSizeWidget {
  const MyCustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: textTheme.displayMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
