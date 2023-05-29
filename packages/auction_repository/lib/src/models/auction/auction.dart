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
  @JsonKey(name: 'auction_id')
  final String id;
  @JsonKey(name: 'item_id')
  final String itemId;
  @JsonKey(name: 'author')
  final User author;
  @JsonKey(name: 'item_name')
  final String itemName;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'date_completed')
  final DateTime? dateCompleted;
  @JsonKey(name: 'initial_price', fromJson: int.parse, defaultValue: 0)
  final int initialPrice;
  @JsonKey(name: 'final_price', fromJson: int.parse, defaultValue: 0)
  final int? finalPrice;
  @JsonKey(name: 'winner')
  final User? winner;
  @JsonKey(name: 'status')
  final AuctionStatus status;
  @JsonKey(name: 'bid_count', defaultValue: 0)
  final int? bidCount;
  @JsonKey(name: 'images')
  final List<ItemImage> images;

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
    this.bidCount,
    this.images = const [],
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
        bidCount,
        images,
      ];
}
