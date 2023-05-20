import 'package:flutter/material.dart';

class MyCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppbar({
    super.key,
    this.textStyle,
    required this.title,
    this.centerTitle = true,
    this.flexibleSpace,
  });

  final Widget? flexibleSpace;
  final bool? centerTitle;
  final TextStyle? textStyle;
  final String title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      // iconTheme: MyAppTheme.appBarIconTheme(),
      flexibleSpace: flexibleSpace,
      backgroundColor: theme.colorScheme.background,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: textStyle ?? theme.textTheme.headlineMedium,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
