import 'package:formz/formz.dart';

import 'package:flutter_online_auction_app/shared/shared.dart';

class NewItemFormState with FormzMixin {
  const NewItemFormState({
    this.status = FormzSubmissionStatus.initial,
    required this.itemName,
    required this.itemDesc,
    required this.itemPrice,
  });

  final FormzSubmissionStatus status;
  final ItemName itemName;
  final ItemDesc itemDesc;
  final ItemPrice itemPrice;

  NewItemFormState copyWith({
    FormzSubmissionStatus? status,
    ItemName? itemName,
    ItemDesc? itemDesc,
    ItemPrice? itemPrice,
  }) {
    return NewItemFormState(
      status: status ?? this.status,
      itemName: itemName ?? this.itemName,
      itemDesc: itemDesc ?? this.itemDesc,
      itemPrice: itemPrice ?? this.itemPrice,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [itemName, itemDesc, itemPrice];
}
