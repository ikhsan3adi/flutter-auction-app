import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({
    required AuctionRepository auctionRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _auctionRepository = auctionRepository,
        _authenticationRepository = authenticationRepository,
        super(ExploreInitial()) {
    on<ExploreFetchAuctionEvent>(_fetchAuction);
  }

  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchAuction(ExploreFetchAuctionEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreLoading());

    try {
      await _auctionRepository.getAuctions();

      List<Auction> latestAuctions = _auctionRepository.getLatestAuction();
      List<Auction> randomAuctions = _auctionRepository.getRandomAuction();
      List<Auction> otherAuctions = _auctionRepository.getOtherAuction();

      emit(ExploreLoaded(
        latestAuctionList: latestAuctions,
        randomAuctionList: randomAuctions,
        otherAuctionList: otherAuctions,
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(ExploreError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(ExploreError(messages: e.errorsMessages));
    } catch (e) {
      emit(ExploreError(messages: [e.toString()]));
    }
  }
}
