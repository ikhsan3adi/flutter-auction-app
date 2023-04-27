import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bid.g.dart';

@JsonSerializable()
class Bid extends Equatable {
  final int id;
  final int userId;
  final int auctionId;
  final String username;
  final String name;
  final int bidPrice;
  final DateTime dateCreated;
  final String profileImageUrl;
  final bool mine;

  const Bid({
    required this.id,
    required this.userId,
    required this.auctionId,
    required this.username,
    required this.name,
    required this.bidPrice,
    required this.dateCreated,
    required this.profileImageUrl,
    required this.mine,
  });

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);

  Map<String, dynamic> toJson() => _$BidToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        auctionId,
        username,
        name,
        bidPrice,
        dateCreated,
        profileImageUrl,
        mine,
      ];
}
