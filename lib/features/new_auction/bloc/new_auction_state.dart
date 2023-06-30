part of 'new_auction_bloc.dart';

class NewAuctionState extends Equatable {
  const NewAuctionState();

  @override
  List<Object?> get props => [];
}

class NewAuctionLoading extends NewAuctionState {}

class NewAuctionLoaded extends NewAuctionState {
  const NewAuctionLoaded({
    required this.itemList,
    this.selectedItem,
    this.finishedDate,
    this.status = FormzSubmissionStatus.initial,
    this.errorSubmissionMessage,
  });

  final List<Item> itemList;
  final Item? selectedItem;
  final DateTime? finishedDate;

  final FormzSubmissionStatus status;
  final String? errorSubmissionMessage;

  NewAuctionLoaded copyWith({
    List<Item>? itemList,
    Item? selectedItem,
    DateTime? finishedDate,
    FormzSubmissionStatus? status,
    String? errorSubmissionMessage,
  }) {
    return NewAuctionLoaded(
      itemList: itemList ?? this.itemList,
      selectedItem: selectedItem ?? this.selectedItem,
      finishedDate: finishedDate ?? this.finishedDate,
      status: status ?? this.status,
      errorSubmissionMessage: errorSubmissionMessage ?? this.errorSubmissionMessage,
    );
  }

  @override
  List<Object> get props => [
        itemList,
        selectedItem ?? Item,
        finishedDate ?? DateTime,
        status,
        errorSubmissionMessage ?? '',
      ];
}

class NewAuctionError extends NewAuctionState {
  const NewAuctionError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
