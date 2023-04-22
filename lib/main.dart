import 'package:flutter_online_auction_app/app.dart';
import 'package:flutter_online_auction_app/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
