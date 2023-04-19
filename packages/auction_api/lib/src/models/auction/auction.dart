import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auction.g.dart';

enum AuctionStatus {
  open,
  closed,
}

@JsonSerializable()
class Auction extends Equatable {
  final int id;

  final int ownerUserId;
  final String ownerUsername;
  final String ownerName;

  final int itemId;
  final String itemName;
  final String description;

  final DateTime dateCreated;
  final DateTime dateCompleted;

  final int initialPrice;
  final int? finalPrice;

  final int? winnerUserId;
  final String? winnerUsername;
  final String? winnerName;

  final AuctionStatus status;
  final List<String> imageUrls;

  const Auction({
    required this.id,
    required this.itemId,
    required this.ownerUserId,
    required this.ownerUsername,
    required this.ownerName,
    required this.itemName,
    required this.description,
    required this.dateCreated,
    required this.dateCompleted,
    required this.initialPrice,
    required this.finalPrice,
    this.winnerUserId,
    this.winnerName,
    this.winnerUsername,
    required this.status,
    required this.imageUrls,
  });

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionToJson(this);

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
        dateCompleted,
        initialPrice,
        finalPrice,
        winnerUserId,
        winnerUsername,
        winnerName,
        status,
        imageUrls,
      ];

  static List<Auction> dummyAuction = [];
}
