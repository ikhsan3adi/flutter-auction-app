import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final int id;

  final int ownerUserId;
  final String ownerUsername;
  final String ownerName;

  final int itemId;
  final String itemName;
  final String description;

  final DateTime dateCreated;

  final int initialPrice;

  final List<ItemImage> images;

  const Item({
    required this.id,
    required this.itemId,
    required this.ownerUserId,
    required this.ownerUsername,
    required this.ownerName,
    required this.itemName,
    required this.description,
    required this.dateCreated,
    required this.initialPrice,
    required this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props => [
        id,
        ownerUserId,
        ownerUsername,
        ownerName,
        itemId,
        itemName,
        description,
        dateCreated,
        initialPrice,
        images,
      ];
}

@JsonSerializable()
class ItemImage extends Equatable {
  const ItemImage({required this.id, required this.url});

  final int id;
  final String url;

  factory ItemImage.fromJson(Map<String, dynamic> json) => _$ItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$ItemImageToJson(this);

  @override
  List<Object?> get props => [id, url];
}
