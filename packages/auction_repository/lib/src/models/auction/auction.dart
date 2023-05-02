import 'package:auction_repository/src/models/item_image/item_image.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'auction.g.dart';

enum AuctionStatus {
  open,
  closed,
}

@JsonSerializable()
class Auction extends Equatable {
  final int id;
  final int itemId;

  final User author;

  final String itemName;
  final String description;

  final DateTime createdAt;
  final DateTime? dateCompleted;

  final int initialPrice;
  final int? finalPrice;

  final User? winner;

  final AuctionStatus status;
  final List<ItemImage> imageUrls;

  const Auction({
    required this.id,
    required this.itemId,
    this.author = const User(id: '-', username: '', email: '', name: ''),
    required this.itemName,
    required this.description,
    required this.createdAt,
    required this.dateCompleted,
    required this.initialPrice,
    required this.finalPrice,
    this.winner,
    required this.status,
    required this.imageUrls,
  });

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionToJson(this);

  @override
  List<Object?> get props => [
        id,
        author,
        itemId,
        itemName,
        description,
        createdAt,
        dateCompleted,
        initialPrice,
        finalPrice,
        winner,
        status,
        imageUrls,
      ];
}
