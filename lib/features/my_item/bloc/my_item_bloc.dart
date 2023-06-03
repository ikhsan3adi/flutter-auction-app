import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_auction_app/features/my_item/my_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'my_item_event.dart';
part 'my_item_state.dart';

class MyItemBloc extends Bloc<MyItemEvent, MyItemState> {
  MyItemBloc({
    required ItemRepository itemRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _itemRepository = itemRepository,
        _authenticationRepository = authenticationRepository,
        super(MyItemInitial()) {
    on<FetchMyItem>(_fetchItem);
    on<FilterMyItem>(_filterItem);
    on<DeleteItem>(_deleteItem);
  }

  final ItemRepository _itemRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _fetchItem(FetchMyItem event, Emitter<MyItemState> emit) async {
    emit(MyItemLoading());

    try {
      final items = await _itemRepository.getItems();

      emit(MyItemLoaded(items: items, filteredItems: items));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(MyItemError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(MyItemError(messages: e.errorsMessages));
    } catch (e) {
      emit(MyItemError(messages: [e.toString()]));
    }
  }

  Future<void> _filterItem(FilterMyItem event, Emitter<MyItemState> emit) async {
    final currentState = state as MyItemLoaded;

    switch (event.filter) {
      case ItemFilter.all:
        return emit(currentState.copyWith(
          filteredItems: currentState.items,
          filter: ItemFilter.all,
        ));
      case ItemFilter.auctioned:
        return emit(currentState.copyWith(
          filteredItems: currentState.items.where((element) => element.auctioned).toList(),
          filter: ItemFilter.auctioned,
        ));
      case ItemFilter.inactive:
        return emit(currentState.copyWith(
          filteredItems: currentState.items.where((element) => !element.auctioned).toList(),
          filter: ItemFilter.inactive,
        ));
    }
  }

  Future<void> _deleteItem(DeleteItem event, Emitter<MyItemState> emit) async {
    try {
      await _itemRepository.deleteItem(event.item.id);

      emit(MyItemLoading());

      final List<Item> items = await _itemRepository.getItems();

      emit(MyItemLoaded(items: items, filteredItems: items));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );

      emit(MyItemError(messages: e.errorsMessages));
    } on DioError catch (e) {
      emit(MyItemError(messages: e.errorsMessages));
    } catch (e) {
      emit(MyItemError(messages: [e.toString()]));
    }
  }
}
