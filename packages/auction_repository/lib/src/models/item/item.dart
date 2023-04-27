import 'package:auction_repository/src/models/item_image/item_image.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final int id;
  final int userId;
  final String itemName;
  final String description;
  final DateTime createdAt;
  final int initialPrice;
  final List<ItemImage> images;

  const Item({
    required this.id,
    required this.userId,
    required this.itemName,
    required this.description,
    required this.createdAt,
    required this.initialPrice,
    required this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        itemName,
        description,
        createdAt,
        initialPrice,
        images,
      ];
}
