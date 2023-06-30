part of 'new_auction_bloc.dart';

abstract class NewAuctionEvent extends Equatable {
  const NewAuctionEvent();

  @override
  List<Object> get props => [];
}

class FetchAuctionItems extends NewAuctionEvent {}

class AuctionItemChanged extends NewAuctionEvent {
  const AuctionItemChanged({required this.item});

  final Item item;

  @override
  List<Object> get props => [item];
}

class FinishedDateChanged extends NewAuctionEvent {
  const FinishedDateChanged({required this.finishedDate});

  final DateTime finishedDate;

  @override
  List<Object> get props => [finishedDate];
}

class CreateNewAuction extends NewAuctionEvent {}
