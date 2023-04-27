import 'package:auction_repository/auction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    on<ExploreFetchAuctionEvent>(_fetchAuction);
  }

  Future<void> _fetchAuction(ExploreFetchAuctionEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreLoading());

    // TODO: fetch data from repository

    emit(const ExploreLoaded(
      latestAuctionList: [],
      randomAuctionList: [],
      otherAuctionList: [],
    ));
  }
}
