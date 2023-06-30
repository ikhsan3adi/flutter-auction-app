import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'auction_detail_event.dart';
part 'auction_detail_state.dart';

class AuctionDetailBloc extends Bloc<AuctionDetailEvent, AuctionDetailState> {
  AuctionDetailBloc({
    required AuctionRepository auctionRepository,
    required BidRepository bidRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _auctionRepository = auctionRepository,
        _bidRepository = bidRepository,
        _authenticationRepository = authenticationRepository,
        super(AuctionDetailLoading()) {
    on<AuctionDetailGetAuctionEvent>(_fetchAuction);
    on<AuctionDetailDeleteBidEvent>(_deleteBid);
    on<AuctionDetailDeleteAuction>(_deleteAuction);
  }

  final AuthenticationRepository _authenticationRepository;
  final AuctionRepository _auctionRepository;
  final BidRepository _bidRepository;

  Future<void> _fetchAuction(AuctionDetailGetAuctionEvent event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());

    try {
      final Auction auction = await _auctionRepository.getAuction(event.auction.id);
      final List<Bid> bids = await _bidRepository.getBids(auctionId: event.auction.id);

      emit(AuctionDetailLoaded(auction: auction, bidList: bids));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(AuctionDetailError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(AuctionDetailError(messages: e.errorsMessages));
    } catch (e) {
      emit(AuctionDetailError(messages: [e.toString()]));
    }
  }

  Future<void> _deleteBid(AuctionDetailDeleteBidEvent event, Emitter<AuctionDetailState> emit) async {
    try {
      final currentState = state as AuctionDetailLoaded;

      await _bidRepository.deleteBid(event.bid);

      final Auction auction = await _auctionRepository.getAuction(currentState.auction.id);
      final List<Bid> bids = await _bidRepository.getBids(auctionId: currentState.auction.id);

      emit(AuctionDetailLoading());

      emit(AuctionDetailLoaded(auction: auction, bidList: bids));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(AuctionDetailError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(AuctionDetailError(messages: e.errorsMessages));
    } catch (e) {
      emit(AuctionDetailError(messages: [e.toString()]));
    }
  }

  Future<void> _deleteAuction(AuctionDetailDeleteAuction event, Emitter<AuctionDetailState> emit) async {
    try {
      final currentState = state as AuctionDetailLoaded;

      emit(AuctionDetailLoading());

      await _auctionRepository.deleteAuction(currentState.auction.id);

      emit(AuctionDeleted(auction: currentState.auction, bidList: currentState.bidList));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(AuctionDetailError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(AuctionDetailError(messages: e.errorsMessages));
    } catch (e) {
      emit(AuctionDetailError(messages: [e.toString()]));
    }
  }
}
