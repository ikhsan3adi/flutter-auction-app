import 'package:aplikasi_lelang_online/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auction_detail_event.dart';
part 'auction_detail_state.dart';

class AuctionDetailBloc extends Bloc<AuctionDetailEvent, AuctionDetailState> {
  AuctionDetailBloc() : super(AuctionDetailLoading()) {
    on<AuctionDetailGetAuctionEvent>((event, emit) {
      emit(AuctionDetailLoading());
      emit(AuctionDetailLoaded(event.lelang, const <Penawaran>[]));
    });
  }
}
