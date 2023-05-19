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

  final int currentPage;
  final bool hasReachedMax;

  const ExploreLoaded({
    required this.latestAuctionList,
    required this.randomAuctionList,
    required this.otherAuctionList,
    required this.currentPage,
    this.hasReachedMax = false,
  });

  ExploreLoaded copyWith({
    List<Auction>? latestAuctionList,
    List<Auction>? randomAuctionList,
    List<Auction>? otherAuctionList,
    int? currentPage,
    bool? hasReachedMax,
  }) =>
      ExploreLoaded(
        latestAuctionList: latestAuctionList ?? this.latestAuctionList,
        randomAuctionList: randomAuctionList ?? this.randomAuctionList,
        otherAuctionList: otherAuctionList ?? this.otherAuctionList,
        currentPage: currentPage ?? this.currentPage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object> get props => [
        latestAuctionList,
        randomAuctionList,
        otherAuctionList,
        currentPage,
        hasReachedMax,
      ];
}

class ExploreError extends ExploreState {
  const ExploreError({required this.messages});

  final List<String> messages;

  @override
  List<Object> get props => [messages];
}
