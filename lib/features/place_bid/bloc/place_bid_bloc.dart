import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'place_bid_event.dart';
part 'place_bid_state.dart';

class PlaceBidBloc extends Bloc<PlaceBidEvent, PlaceBidState> {
  PlaceBidBloc({
    required BidRepository bidRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _bidRepository = bidRepository,
        _authenticationRepository = authenticationRepository,
        super(PlaceBidInitial()) {
    on<AttemptPlaceBid>((event, emit) async {
      emit(PlaceBidLoading());

      try {
        final Bid newBid = Bid(
          id: '',
          auctionId: event.auctionId,
          bidPrice: event.bidPrice,
          createdAt: DateTime.now(),
          profileImageUrl: '',
        );

        await _bidRepository.placeBid(newBid);

        emit(PlaceBidSuccess());
      } on UnauthorizedException catch (e) {
        _authenticationRepository.changeAuthStatus(
          status: Unauthenticated(messages: e.errorsMessages, forced: true),
        );
      } on DioError catch (e) {
        emit(PlaceBidFailed(message: e.errorsMessages[0]));
      } catch (e) {
        emit(PlaceBidFailed(message: e.toString()));
      }
    });
  }

  final BidRepository _bidRepository;
  final AuthenticationRepository _authenticationRepository;
}
