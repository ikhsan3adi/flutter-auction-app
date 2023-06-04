import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData theme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      textTheme: myTextTheme(),
      fontFamily: "Open Sans",
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
      textTheme: myTextTheme(),
      fontFamily: "Open Sans",
      useMaterial3: true,
    );
  }

  static TextTheme myTextTheme() {
    const String poppinsFont = 'Poppins';
    const String openSansFont = 'Open Sans';
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.w800, fontSize: 57),
      displayMedium: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.w800, fontSize: 45),
      displaySmall: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.w800, fontSize: 36),
      //
      headlineLarge: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.bold, fontSize: 32),
      headlineMedium: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.bold, fontSize: 26),
      headlineSmall: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.bold, fontSize: 20),
      titleLarge: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.bold, fontSize: 22),
      titleMedium: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.bold, fontSize: 16),
      titleSmall: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.bold, fontSize: 14),
      bodyLarge: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.normal, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.normal, fontSize: 14),
      bodySmall: TextStyle(fontFamily: openSansFont, fontWeight: FontWeight.normal, fontSize: 12),

      // for app title, appbar
      // labelLarge: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.bold, fontSize: 26),
      // labelMedium: TextStyle(fontFamily: poppinsFont, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
