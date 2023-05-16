import 'package:flutter/material.dart';

class MyCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppbar({
    super.key,
    this.textStyle,
    required this.title,
    this.centerTitle = true,
    this.flexibleSpace,
    this.foregroundColor,
  });

  final Color? foregroundColor;
  final Widget? flexibleSpace;
  final bool? centerTitle;
  final TextStyle? textStyle;
  final String title;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      // iconTheme: MyAppTheme.appBarIconTheme(),
      flexibleSpace: flexibleSpace,
      backgroundColor: Colors.white.withOpacity(0),
      foregroundColor: foregroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: textStyle ?? textTheme.headlineMedium!.copyWith(color: Colors.black87),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
