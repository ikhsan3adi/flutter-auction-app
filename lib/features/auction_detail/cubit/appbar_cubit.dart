import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit() : super(AppbarInitial());

  void scrolled(double scrollPos) {
    double factor = clampDouble((scrollPos - 100) / 400, 0.0, 1.0);
    double elevation = clampDouble((scrollPos - 300) / 400, 0.0, 1.0);
    emit(
      AppbarChanged(
        backgroundColor: Color.lerp(Colors.transparent, Colors.white, factor)!,
        foregroundColor: Color.lerp(Colors.white, Colors.black87, factor - 0.2)!,
        elevation: elevation,
        shadowText: Color.lerp(Colors.black54, Colors.transparent, factor)!,
      ),
    );
  }
}
