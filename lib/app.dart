import 'package:flutter/material.dart';
import 'package:flutter_online_auction_app/features/home/home.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class MyApp extends MaterialApp {
  MyApp({super.key})
      : super(
          title: "Online Auction App",
          theme: MyAppTheme.theme(),
          darkTheme: MyAppTheme.darkTheme(),
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: HomePage.routeName,
          home: const HomePage(),
        );
}
