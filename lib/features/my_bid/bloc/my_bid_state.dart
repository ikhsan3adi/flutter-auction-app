// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_bid_bloc.dart';

abstract class MyBidState extends Equatable {
  const MyBidState();

  @override
  List<Object> get props => [];
}

class MyBidInitial extends MyBidState {}

class MyBidLoading extends MyBidState {}

class MyBidLoaded extends MyBidState {
  const MyBidLoaded({
    required this.bidWithAuctions,
    required this.filteredAuctions,
    this.filter = MyBidFilter.ongoing,
  });

  final List<BidWithAuction> bidWithAuctions;
  final List<BidWithAuction> filteredAuctions;
  final MyBidFilter filter;

  MyBidLoaded copyWith({
    List<BidWithAuction>? bidWithAuctions,
    List<BidWithAuction>? filteredAuctions,
    MyBidFilter? filter,
  }) {
    return MyBidLoaded(
      bidWithAuctions: bidWithAuctions ?? this.bidWithAuctions,
      filteredAuctions: filteredAuctions ?? this.filteredAuctions,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [bidWithAuctions, filteredAuctions, filter];
}

class MyBidError extends MyBidState {
  const MyBidError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
