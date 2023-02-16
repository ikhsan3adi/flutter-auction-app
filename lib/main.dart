import 'package:aplikasi_lelang_online/app.dart';
import 'package:aplikasi_lelang_online/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
