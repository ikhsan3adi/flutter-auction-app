import 'package:auction_repository/auction_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

part 'update_item_event.dart';
part 'update_item_state.dart';

class UpdateItemBloc extends Bloc<UpdateItemEvent, UpdateItemState> {
  UpdateItemBloc({
    required ItemRepository itemRepository,
    required AuthenticationRepository authenticationRepository,
    required TokenRepository tokenRepository,
  })  : _itemRepository = itemRepository,
        _authenticationRepository = authenticationRepository,
        _tokenRepository = tokenRepository,
        super(UpdateItemInitial()) {
    on<FetchItemData>(_fetchItem);
    on<ItemImagesChanged>(_itemImagesChanged);
    on<ItemImageDelete>(_deleteItemImage);
    on<FormerItemImageDelete>(_deleteFormerImage);
    on<ItemNameChanged>(_onItemNameChanged);
    on<ItemDescChanged>(_onItemDescChanged);
    on<ItemPriceChanged>(_onItemPriceChanged);
    on<UpdateItem>(_updateNewItem);
  }

  final ItemRepository _itemRepository;
  final AuthenticationRepository _authenticationRepository;
  final TokenRepository _tokenRepository;

  Future<void> _fetchItem(FetchItemData event, Emitter<UpdateItemState> emit) async {
    emit(UpdateItemLoading());

    try {
      final Item item = await _itemRepository.getItem(event.item.id);

      emit(UpdateItemLoaded(
        itemId: item.id,
        formerImages: item.images,
        formState: ItemFormState(
          itemName: ItemName.dirty(item.itemName),
          itemDesc: ItemDesc.dirty(item.description),
          itemPrice: ItemPrice.dirty(item.initialPrice),
        ),
        newImagesPath: const [],
        isValid: true,
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
    } on DioError catch (e) {
      emit(UpdateItemError(message: e.errorsMessages[0]));
    } catch (e) {
      emit(UpdateItemError(message: e.toString()));
    }
  }

  void _itemImagesChanged(ItemImagesChanged event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    emit(currentState.copyWith(
      newImagesPath: [...currentState.newImagesPath, ...event.imagesPath],
      formerImages: currentState.formerImages,
      formState: currentState.formState,
      isValid: currentState.isValid,
    ));
  }

  void _deleteItemImage(ItemImageDelete event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    emit(currentState.copyWith(
      newImagesPath: List.from(currentState.newImagesPath)..removeAt(event.index),
      formerImages: currentState.formerImages,
      formState: currentState.formState,
      isValid: currentState.isValid,
    ));
  }

  void _deleteFormerImage(FormerItemImageDelete event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    emit(currentState.copyWith(
      newImagesPath: currentState.newImagesPath,
      formerImages: List.from(currentState.formerImages)..remove(event.itemImage),
      formState: currentState.formState,
      isValid: currentState.isValid,
    ));
  }

  void _onItemNameChanged(ItemNameChanged event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    final itemName = ItemName.dirty(event.itemName);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(itemName: itemName),
      isValid: Formz.validate([itemName, currentState.formState.itemDesc, currentState.formState.itemPrice]),
      formerImages: currentState.formerImages,
      newImagesPath: currentState.newImagesPath,
    ));
  }

  void _onItemDescChanged(ItemDescChanged event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    final itemDesc = ItemDesc.dirty(event.itemDesc);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(itemDesc: itemDesc),
      isValid: Formz.validate([currentState.formState.itemName, itemDesc, currentState.formState.itemPrice]),
      formerImages: currentState.formerImages,
      newImagesPath: currentState.newImagesPath,
    ));
  }

  void _onItemPriceChanged(ItemPriceChanged event, Emitter<UpdateItemState> emit) {
    final currentState = state as UpdateItemLoaded;
    final itemPrice = ItemPrice.dirty(event.itemPrice);
    emit(currentState.copyWith(
      formState: currentState.formState.copyWith(itemPrice: itemPrice),
      isValid: Formz.validate([currentState.formState.itemName, currentState.formState.itemDesc, itemPrice]),
      formerImages: currentState.formerImages,
      newImagesPath: currentState.newImagesPath,
    ));
  }

  Future<void> _updateNewItem(UpdateItem event, Emitter<UpdateItemState> emit) async {
    final currentState = state as UpdateItemLoaded;
    if (!currentState.isValid || currentState.formState.isNotValid) return;

    try {
      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.inProgress),
        formerImages: currentState.formerImages,
        isValid: currentState.isValid,
        newImagesPath: currentState.newImagesPath,
      ));

      final Item newItem = Item(
        id: currentState.itemId,
        userId: _tokenRepository.token?.userData?.id ?? '',
        itemName: currentState.formState.itemName.value,
        description: currentState.formState.itemDesc.value,
        createdAt: DateTime.now(),
        initialPrice: currentState.formState.itemPrice.value,
        auctioned: false,
        images: currentState.newImagesPath.map((e) => ItemImage(url: e)).toList(),
      );

      List<String> formerImageIds = currentState.formerImages.map((e) => e.id ?? "-69Waduh").toList();

      await _itemRepository.updateItem(newItem, formerImageIds);

      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.success),
        formerImages: currentState.formerImages,
        isValid: currentState.isValid,
        newImagesPath: currentState.newImagesPath,
      ));
    } on UnauthorizedException catch (e) {
      _authenticationRepository.changeAuthStatus(
        status: Unauthenticated(messages: e.errorsMessages, forced: true),
      );
    } on DioError catch (e) {
      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.failure),
        formerImages: currentState.formerImages,
        isValid: currentState.isValid,
        newImagesPath: currentState.newImagesPath,
        message: e.errorsMessages[0],
      ));
    } catch (e) {
      emit(currentState.copyWith(
        formState: currentState.formState.copyWith(status: FormzSubmissionStatus.failure),
        formerImages: currentState.formerImages,
        isValid: currentState.isValid,
        newImagesPath: currentState.newImagesPath,
        message: e.toString(),
      ));
    }
  }
}
