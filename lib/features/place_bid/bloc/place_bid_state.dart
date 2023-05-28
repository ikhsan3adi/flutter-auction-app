part of 'place_bid_bloc.dart';

abstract class PlaceBidState extends Equatable {
  const PlaceBidState();

  @override
  List<Object> get props => [];
}

class PlaceBidInitial extends PlaceBidState {}

class PlaceBidLoading extends PlaceBidState {}

class PlaceBidSuccess extends PlaceBidState {}

class PlaceBidFailed extends PlaceBidState {
  const PlaceBidFailed({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
