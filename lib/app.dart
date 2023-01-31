import 'package:flutter/material.dart';
import 'package:aplikasi_lelang_online/features/home/home.dart';
import 'package:aplikasi_lelang_online/shared/shared.dart';

class MyApp extends MaterialApp {
  MyApp({super.key})
      : super(
          title: "Online Auction App",
          theme: MyAppTheme.theme(),
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: HomePage.routeName,
          home: const HomePage(),
        );
}
