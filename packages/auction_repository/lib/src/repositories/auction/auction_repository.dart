import 'dart:math';

import 'package:auction_repository/src/models/models.dart';
import 'auction_api.dart';

class AuctionRepository {
  AuctionRepository({
    required AuctionApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuctionApiClient _apiClient;

  List<Auction>? _auctions;
  List<String>? _randomAuctionsIds;

  Future<void> getAuctions() async {
    _auctions = [
      ...await _apiClient.getAuctions(1),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<Auction>> getMoreAuctions(int page) async {
    return [
      ...await _apiClient.getAuctions(page),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<Auction> getAuction(String id) async {
    final auction = await _apiClient.getAuction(id);
    return auction;
  }

  Future<void> createAuction(Auction auction) async {
    await _apiClient.createAuction(auction);
  }

  Future<void> updateAuction(Auction auction) async {
    await _apiClient.updateAuction(auction);
  }

  Future<void> deleteAuction(String id) async {
    await _apiClient.deleteAuction(id);
  }

  Future<List<Auction>> getMyAuctions() async {
    return [
      ...await _apiClient.getMyAuctions(),
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<BidWithAuction>> getMyBidAuctions() async {
    return [...await _apiClient.getMyBidAuctions()]
        .map((e) => BidWithAuction(
              auction: e.auction,
              bids: e.bids..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
            ))
        .toList()
      ..sort((a, b) => b.bids.first.createdAt.compareTo(a.bids.first.createdAt));
  }

  Future<void> setAuctionWinner({required String auctionId, required Bid bid}) async {
    return await _apiClient.setAuctionWinner(auctionId, bid);
  }

  Future<void> closeAuction(String auctionId) async {
    return await _apiClient.closeAuction(auctionId);
  }

  List<Auction> getLatestAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    return auctions.take(3).toList();
  }

  List<Auction> getRandomAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    if (auctions.isEmpty || auctions.length <= 3) return [];

    Random r = Random(4321);

    _randomAuctionsIds = [
      ...auctions.map((e) => e.id).toList()
        ..removeRange(0, 3)
        ..shuffle(r)
    ].take(5).toList();

    return [
      ...auctions
        ..removeRange(0, 3)
        ..shuffle(r)
    ].take(5).toList();
  }

  List<Auction> getOtherAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    if (auctions.isEmpty || auctions.length <= 8) return [];

    return auctions
      ..removeRange(0, 3)
      ..removeWhere((element) => (_randomAuctionsIds ?? []).contains(element.id));
  }
}
