import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbar_state.dart';

class AppbarCubit extends Cubit<AppbarState> {
  AppbarCubit({required this.themeMode, required this.theme}) : super(AppbarInitial()) {
    _foregorundColor = theme.textTheme.bodyLarge?.color ?? (themeMode == ThemeMode.light ? Colors.black87 : Colors.white);
    _backgroundColor = theme.colorScheme.background;
  }

  final ThemeData theme;
  final ThemeMode themeMode;

  late final Color _foregorundColor;
  late final Color _backgroundColor;

  void scrolled(double scrollPos) {
    double factor = clampDouble((scrollPos - 100) / 400, 0.0, 1.0);
    double elevation = clampDouble((scrollPos - 300) / 400, 0.0, 1.0);
    emit(
      AppbarChanged(
        backgroundColor: Color.lerp(Colors.transparent, _backgroundColor, factor)!,
        foregroundColor: Color.lerp(Colors.white, _foregorundColor, factor - 0.2)!,
        elevation: elevation,
        shadowText: Color.lerp(Colors.black54, Colors.transparent, factor)!,
      ),
    );
  }
}
