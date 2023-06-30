import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'new_item_event.dart';
part 'new_item_state.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  NewItemBloc({
    required ItemRepository itemRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _itemRepository = itemRepository,
        _authenticationRepository = authenticationRepository,
        super(const NewItemState()) {
    on<ItemImagesChanged>(_itemImagesChanged);
    on<ItemImageDelete>(_deleteItemImage);
    on<ItemNameChanged>(_onItemNameChanged);
    on<ItemDescChanged>(_onItemDescChanged);
    on<ItemPriceChanged>(_onItemPriceChanged);
    on<CreateNewItem>(_createNewItem);
  }

  final ItemRepository _itemRepository;
  final AuthenticationRepository _authenticationRepository;

  void _itemImagesChanged(ItemImagesChanged event, Emitter<NewItemState> emit) {
    emit(state.copyWith(imagesPath: [...state.imagesPath, ...event.imagesPath]));
  }

  void _deleteItemImage(ItemImageDelete event, Emitter<NewItemState> emit) {
    emit(state.copyWith(imagesPath: List.from(state.imagesPath)..removeAt(event.index)));
  }

  void _onItemNameChanged(ItemNameChanged event, Emitter<NewItemState> emit) {
    final itemName = ItemName.dirty(event.itemName);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemName: itemName),
      isValid: Formz.validate([itemName, state.formState.itemDesc, state.formState.itemPrice]),
    ));
  }

  void _onItemDescChanged(ItemDescChanged event, Emitter<NewItemState> emit) {
    final itemDesc = ItemDesc.dirty(event.itemDesc);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemDesc: itemDesc),
      isValid: Formz.validate([state.formState.itemName, itemDesc, state.formState.itemPrice]),
    ));
  }

  void _onItemPriceChanged(ItemPriceChanged event, Emitter<NewItemState> emit) {
    final itemPrice = ItemPrice.dirty(int.tryParse(event.itemPrice) ?? 0);
    emit(state.copyWith(
      formState: state.formState.copyWith(itemPrice: itemPrice),
      isValid: Formz.validate([state.formState.itemName, state.formState.itemDesc, itemPrice]),
    ));
  }

  Future<void> _createNewItem(CreateNewItem event, Emitter<NewItemState> emit) async {
    if (!state.isValid || state.formState.isNotValid) return;

    try {
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.inProgress),
      ));

      final Item newItem = Item(
        id: 'id',
        userId: '-',
        itemName: state.formState.itemName.value,
        description: state.formState.itemDesc.value,
        createdAt: DateTime.now(),
        initialPrice: state.formState.itemPrice.value,
        auctioned: false,
        images: state.imagesPath.map((e) => ItemImage(url: e)).toList(),
      );

      await _itemRepository.createItem(newItem);

      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.success),
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
        errorMessage: e.errorsMessages[0],
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
        errorMessage: e.errorsMessages[0],
      ));
    } catch (e) {
      emit(state.copyWith(
        formState: state.formState.copyWith(status: FormzSubmissionStatus.failure),
        errorMessage: e.toString(),
      ));
    }
  }
}
