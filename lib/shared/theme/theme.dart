import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData theme() {
    return ThemeData(
      textTheme: myTextTheme(),
    );
  }

  static TextTheme myTextTheme() {
    const String poppinsFont = 'Poppins';
    const String openSansFont = 'Open Sans';
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: poppinsFont),
      displayMedium: TextStyle(fontFamily: poppinsFont),
      displaySmall: TextStyle(fontFamily: poppinsFont),
      headlineMedium: TextStyle(fontFamily: openSansFont),
      headlineSmall: TextStyle(fontFamily: openSansFont),
      titleLarge: TextStyle(fontFamily: openSansFont),
      bodyLarge: TextStyle(fontFamily: openSansFont),
      bodyMedium: TextStyle(fontFamily: openSansFont),
    );
  }
}
