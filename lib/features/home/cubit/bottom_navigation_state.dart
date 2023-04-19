part of 'bottom_navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationLoaded extends NavigationState {
  const NavigationLoaded(this.pageIndex);

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
