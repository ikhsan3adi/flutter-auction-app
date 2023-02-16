part of 'auction_detail_bloc.dart';

abstract class AuctionDetailState extends Equatable {
  const AuctionDetailState();

  @override
  List<Object> get props => [];
}

class AuctionDetailLoading extends AuctionDetailState {}

class AuctionDetailLoaded extends AuctionDetailState {
  final Lelang lelang;
  final List<Penawaran> penawaranList;

  const AuctionDetailLoaded(this.lelang, this.penawaranList);

  @override
  List<Object> get props => [lelang];
}
