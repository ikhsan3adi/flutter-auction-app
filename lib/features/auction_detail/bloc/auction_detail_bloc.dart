import 'package:auction_api/auction_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auction_detail_event.dart';
part 'auction_detail_state.dart';

class AuctionDetailBloc extends Bloc<AuctionDetailEvent, AuctionDetailState> {
  AuctionDetailBloc() : super(AuctionDetailLoading()) {
    on<AuctionDetailGetAuctionEvent>(_fetchAuction);
  }

  Future<void> _fetchAuction(AuctionDetailGetAuctionEvent event, Emitter<AuctionDetailState> emit) async {
    emit(AuctionDetailLoading());
    emit(AuctionDetailLoaded(auction: event.auction, bidList: const []));
  }
}
