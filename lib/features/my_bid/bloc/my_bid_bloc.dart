import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_bid/my_bid.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'my_bid_event.dart';
part 'my_bid_state.dart';

class MyBidBloc extends Bloc<MyBidEvent, MyBidState> {
  MyBidBloc({
    required AuctionRepository auctionRepository,
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
  })  : _auctionRepository = auctionRepository,
        _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        super(MyBidInitial()) {
    on<FetchMyBidAuction>(_fetchMyBid);
    on<FilterMyBid>(_filterBid);
  }

  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;
  final TokenRepository _tokenRepository;

  Future<void> _fetchMyBid(FetchMyBidAuction event, Emitter<MyBidState> emit) async {
    emit(MyBidLoading());

    try {
      final List<BidWithAuction> bidWithAuctions = await _auctionRepository.getMyBidAuctions();

      emit(MyBidLoaded(bidWithAuctions: bidWithAuctions, filteredAuctions: bidWithAuctions));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(MyBidError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(MyBidError(messages: e.errorsMessages));
    } catch (e) {
      emit(MyBidError(messages: [e.toString()]));
    }
  }

  Future<void> _filterBid(FilterMyBid event, Emitter<MyBidState> emit) async {
    if (state is! MyBidLoaded) return;

    final currentState = state as MyBidLoaded;

    switch (event.filter) {
      case MyBidFilter.all:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.bidWithAuctions,
          filter: MyBidFilter.all,
        ));
      case MyBidFilter.ongoing:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.bidWithAuctions.where((e) => e.auction.status == AuctionStatus.open).toList(),
          filter: MyBidFilter.ongoing,
        ));
      case MyBidFilter.win:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.bidWithAuctions.where((e) {
            if (e.auction.winner == null || _tokenRepository.token == null) return false;

            return e.auction.winner?.username == _tokenRepository.token?.userData?.username && e.auction.status == AuctionStatus.closed;
          }).toList(),
          filter: MyBidFilter.win,
        ));
      case MyBidFilter.lose:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.bidWithAuctions.where((e) {
            if (e.auction.winner == null || _tokenRepository.token == null) return false;

            return e.auction.winner?.username != _tokenRepository.token?.userData?.username && e.auction.status == AuctionStatus.closed;
          }).toList(),
          filter: MyBidFilter.lose,
        ));
    }
  }
}
