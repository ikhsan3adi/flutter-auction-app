import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';

part 'new_auction_event.dart';
part 'new_auction_state.dart';

class NewAuctionBloc extends Bloc<NewAuctionEvent, NewAuctionState> {
  NewAuctionBloc({
    required ItemRepository itemRepository,
    required AuctionRepository auctionRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _itemRepository = itemRepository,
        _auctionRepository = auctionRepository,
        _authenticationRepository = authenticationRepository,
        super(const NewAuctionState()) {
    on<FetchAuctionItems>(_fetchItem);
    on<AuctionItemChanged>(_onAuctionItemChanged);
    on<FinishedDateChanged>(_onFinishedDateChanged);
    on<CreateNewAuction>(_createNewAuction);
  }

  final ItemRepository _itemRepository;
  final AuctionRepository _auctionRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchItem(FetchAuctionItems event, Emitter<NewAuctionState> emit) async {
    try {
      emit(NewAuctionLoading());

      final List<Item> items = await _itemRepository.getItems();

      emit(NewAuctionLoaded(itemList: items, selectedItem: null));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(NewAuctionError(message: e.errorsMessages[0]));
    } on DioError catch (e) {
      emit(NewAuctionError(message: e.errorsMessages[0]));
    } catch (e) {
      emit(NewAuctionError(message: e.toString()));
    }
  }

  void _onAuctionItemChanged(AuctionItemChanged event, Emitter<NewAuctionState> emit) {
    if (state is! NewAuctionLoaded) return;

    emit((state as NewAuctionLoaded).copyWith(selectedItem: event.item));
  }

  void _onFinishedDateChanged(FinishedDateChanged event, Emitter<NewAuctionState> emit) {
    if (state is! NewAuctionLoaded) return;

    emit((state as NewAuctionLoaded).copyWith(finishedDate: event.finishedDate));
  }

  Future<void> _createNewAuction(CreateNewAuction event, Emitter<NewAuctionState> emit) async {
    if (state is! NewAuctionLoaded) return;

    final currentState = state as NewAuctionLoaded;

    if (currentState.selectedItem == null) return;

    try {
      emit(currentState.copyWith(status: FormzSubmissionStatus.inProgress));

      final newAuction = Auction(
        id: 'id',
        itemId: currentState.selectedItem!.id,
        itemName: currentState.selectedItem!.itemName,
        description: currentState.selectedItem!.description,
        createdAt: DateTime.now(),
        dateCompleted: currentState.finishedDate,
        initialPrice: currentState.selectedItem!.initialPrice,
        finalPrice: null,
        status: AuctionStatus.open,
      );

      await _auctionRepository.createAuction(newAuction);

      emit(currentState.copyWith(status: FormzSubmissionStatus.success));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(currentState.copyWith(
        status: FormzSubmissionStatus.failure,
        errorSubmissionMessage: e.errorsMessages[0],
      ));
    } on DioError catch (e) {
      emit(currentState.copyWith(
        status: FormzSubmissionStatus.failure,
        errorSubmissionMessage: e.errorsMessages[0],
      ));
    } catch (e) {
      emit(currentState.copyWith(
        status: FormzSubmissionStatus.failure,
        errorSubmissionMessage: e.toString(),
      ));
    }
  }
}
