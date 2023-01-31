import 'package:aplikasi_lelang_online/features/home/home.dart';
import 'package:aplikasi_lelang_online/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("This is ${settings.name} route");
    }

    switch (settings.name) {
      case HomePage.routeName:
        return HomePage.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(appBar: MyCustomAppbar(title: 'Error')),
    );
  }
}
