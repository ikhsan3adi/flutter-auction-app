part of 'update_item_bloc.dart';

abstract class UpdateItemState extends Equatable {
  const UpdateItemState();

  @override
  List<Object> get props => [];
}

class UpdateItemInitial extends UpdateItemState {}

class UpdateItemLoading extends UpdateItemState {}

class UpdateItemLoaded extends UpdateItemState {
  const UpdateItemLoaded({
    required this.itemId,
    required this.formerImages,
    required this.newImagesPath,
    required this.formState,
    required this.isValid,
    this.message,
  });

  final String itemId;
  final List<ItemImage> formerImages;
  final List<String> newImagesPath;
  final ItemFormState formState;
  final bool isValid;
  final String? message;

  UpdateItemLoaded copyWith({
    String? itemId,
    List<ItemImage>? formerImages,
    List<String>? newImagesPath,
    ItemFormState? formState,
    bool? isValid,
    String? message,
  }) {
    return UpdateItemLoaded(
      itemId: itemId ?? this.itemId,
      formerImages: formerImages ?? this.formerImages,
      newImagesPath: newImagesPath ?? this.newImagesPath,
      formState: formState ?? this.formState,
      isValid: isValid ?? this.isValid,
      message: message,
    );
  }

  @override
  List<Object> get props => [itemId, formerImages, newImagesPath, formState, isValid, message ?? ''];
}

class UpdateItemError extends UpdateItemState {
  const UpdateItemError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
