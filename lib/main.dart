import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TokenAdapter());
  Hive.registerAdapter(UserAdapter());

  bootstrap();
}
