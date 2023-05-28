import 'package:auction_repository/src/models/item_image/item_image.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  @JsonKey(name: 'item_id')
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'item_name')
  final String itemName;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'initial_price', fromJson: int.parse, defaultValue: 0)
  final int initialPrice;
  @JsonKey(name: 'images')
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
