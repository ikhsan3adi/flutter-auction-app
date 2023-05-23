import 'package:auction_repository/src/models/models.dart';

import 'bid_api.dart';

class BidRepository {
  BidRepository({
    required BidApiClient apiClient,
  }) : _apiClient = apiClient;

  final BidApiClient _apiClient;

  Future<List<Bid>> getBids({required String auctionId}) async {
    return [
      ...await _apiClient.getAuctionBids(auctionId),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<Bid> getBid(String id) async {
    return await _apiClient.getBid(id);
  }

  Future<void> placeBid(Bid bid) async {
    return await _apiClient.placeBid(bid);
  }

  Future<void> updateBid(Bid bid) async {
    return await _apiClient.updateBid(bid);
  }

  Future<void> deleteBid(Bid bid) async {
    return await _apiClient.deleteBid(bid);
  }
}
