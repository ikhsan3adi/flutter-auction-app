part of 'my_bid_bloc.dart';

abstract class MyBidState extends Equatable {
  const MyBidState();

  @override
  List<Object> get props => [];
}

class MyBidInitial extends MyBidState {}

class MyBidLoading extends MyBidState {}

class MyBidLoaded extends MyBidState {
  const MyBidLoaded({required this.bidWithAuctions});

  final List<BidWithAuction> bidWithAuctions;

  MyBidLoaded copyWith({List<BidWithAuction>? bidWithAuctions}) {
    return MyBidLoaded(bidWithAuctions: bidWithAuctions ?? this.bidWithAuctions);
  }

  @override
  List<Object> get props => [bidWithAuctions];
}

class MyBidError extends MyBidState {
  const MyBidError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
