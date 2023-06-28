import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc({
    required AuthenticationRepository authenticationRepository,
    required ItemRepository itemRepository,
  })  : _authenticationRepository = authenticationRepository,
        _itemRepository = itemRepository,
        super(ItemDetailLoading()) {
    on<ItemDetailGetItemEvent>(_fetchItem);
    on<DeleteItem>(_deleteItem);
  }

  final AuthenticationRepository _authenticationRepository;
  final ItemRepository _itemRepository;

  Future<void> _fetchItem(ItemDetailGetItemEvent event, Emitter<ItemDetailState> emit) async {
    emit(ItemDetailLoading());

    try {
      final Item item = await _itemRepository.getItem(event.item.id);

      emit(ItemDetailLoaded(item: item));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(ItemDetailError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(ItemDetailError(messages: e.errorsMessages));
    } catch (e) {
      emit(ItemDetailError(messages: [e.toString()]));
    }
  }

  Future<void> _deleteItem(DeleteItem event, Emitter<ItemDetailState> emit) async {
    try {
      emit(ItemDetailLoading());

      await _itemRepository.deleteItem(event.item.id);

      emit(ItemDetailDeleted());
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(ItemDetailError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(ItemDetailError(messages: e.errorsMessages));
    } catch (e) {
      emit(ItemDetailError(messages: [e.toString()]));
    }
  }
}
