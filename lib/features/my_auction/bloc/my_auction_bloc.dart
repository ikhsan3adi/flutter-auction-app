import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/my_auction/my_auction.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'my_auction_event.dart';
part 'my_auction_state.dart';

class MyAuctionBloc extends Bloc<MyAuctionEvent, MyAuctionState> {
  MyAuctionBloc({
    required AuctionRepository auctionRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _auctionRepository = auctionRepository,
        _authenticationRepository = authenticationRepository,
        super(MyAuctionInitial()) {
    on<FetchMyAuction>(_fetchAuction);
    on<FilterMyAuction>(_filterAuction);
  }

  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchAuction(FetchMyAuction event, Emitter<MyAuctionState> emit) async {
    emit(MyAuctionLoading());

    try {
      final auctions = await _auctionRepository.getMyAuctions();

      emit(MyAuctionLoaded(auctions: auctions, filteredAuctions: auctions));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(MyAuctionError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(MyAuctionError(messages: e.errorsMessages));
    } catch (e) {
      emit(MyAuctionError(messages: [e.toString()]));
    }
  }

  Future<void> _filterAuction(FilterMyAuction event, Emitter<MyAuctionState> emit) async {
    final currentState = state as MyAuctionLoaded;

    switch (event.filter) {
      case AuctionFilter.all:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.auctions,
          filter: AuctionFilter.all,
        ));
      case AuctionFilter.open:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.auctions.where((element) => element.status == AuctionStatus.open).toList(),
          filter: AuctionFilter.open,
        ));
      case AuctionFilter.closed:
        return emit(currentState.copyWith(
          filteredAuctions: currentState.auctions.where((element) => element.status == AuctionStatus.closed).toList(),
          filter: AuctionFilter.closed,
        ));
    }
  }
}
