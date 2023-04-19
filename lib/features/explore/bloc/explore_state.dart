part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<Auction> latestAuctionList;
  final List<Auction> randomAuctionList;
  final List<Auction> otherAuctionList;

  const ExploreLoaded({
    required this.latestAuctionList,
    required this.randomAuctionList,
    required this.otherAuctionList,
  });

  @override
  List<Object> get props => [
        latestAuctionList,
        randomAuctionList,
        otherAuctionList,
      ];
}

class ExploreError extends ExploreState {
  const ExploreError({required this.msg});

  final String msg;

  @override
  List<Object> get props => [msg];
}
