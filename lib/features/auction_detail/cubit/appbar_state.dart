part of 'appbar_cubit.dart';

abstract class AppbarState extends Equatable {
  const AppbarState();

  @override
  List<Object> get props => [];
}

class AppbarInitial extends AppbarState {}

class AppbarChanged extends AppbarState {
  const AppbarChanged({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.elevation,
    required this.shadowText,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final double elevation;
  final Color shadowText;

  @override
  List<Object> get props => [backgroundColor, foregroundColor, elevation, shadowText];
}
