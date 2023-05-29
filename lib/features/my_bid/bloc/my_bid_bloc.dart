import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'my_bid_event.dart';
part 'my_bid_state.dart';

class MyBidBloc extends Bloc<MyBidEvent, MyBidState> {
  MyBidBloc({
    required AuctionRepository auctionRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _auctionRepository = auctionRepository,
        _authenticationRepository = authenticationRepository,
        super(MyBidInitial()) {
    on<FetchMyBidAuction>(_fetchMyBid);
  }

  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchMyBid(FetchMyBidAuction event, Emitter<MyBidState> emit) async {
    emit(MyBidLoading());

    try {
      final List<BidWithAuction> bidWithAuctions = await _auctionRepository.getMyBidAuctions();

      emit(MyBidLoaded(bidWithAuctions: bidWithAuctions));
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
}
