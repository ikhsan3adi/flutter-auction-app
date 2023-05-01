import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

class AppThemeCubit extends HydratedCubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState());

  void themeChanged(ThemeMode themeMode) => emit(AppThemeState(themeMode: themeMode));

  @override
  AppThemeState? fromJson(Map<String, dynamic> json) => AppThemeState(
        themeMode: ThemeMode.values[json['theme'] as int],
      );

  @override
  Map<String, dynamic>? toJson(AppThemeState state) => {'theme': state.themeMode.index};
}

class AppThemeState extends Equatable {
  const AppThemeState({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
