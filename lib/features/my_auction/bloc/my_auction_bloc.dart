import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchAuction(FetchMyAuction event, Emitter<MyAuctionState> emit) async {
    emit(MyAuctionLoading());

    try {
      final auctions = await _auctionRepository.getMyAuctions();

      emit(MyAuctionLoaded(auctions: auctions));
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
}
