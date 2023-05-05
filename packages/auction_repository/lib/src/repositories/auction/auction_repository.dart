import 'package:auction_repository/src/models/models.dart';
import 'auction_api.dart';

class AuctionRepository {
  AuctionRepository({
    required AuctionApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuctionApiClient _apiClient;

  List<Auction>? _auctions;
  List<String>? _randomAuctionsIds;

  Future<List<Auction>> getAuctions() async {
    _auctions = await _apiClient.getAuctions()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return _auctions ?? [];
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
    return await _apiClient.getMyAuctions();
  }

  Future<void> setAuctionWinner({required String auctionId, required Bid bid}) async {
    return await _apiClient.setAuctionWinner(auctionId, bid);
  }

  Future<void> closeAuction(String auctionId) async {
    return await _apiClient.closeAuction(auctionId);
  }

  List<Auction> getLatestAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    if (auctions.isEmpty) {
      return [];
    } else if (auctions.length <= 3) {
      return auctions;
    }

    return auctions..take(3);
  }

  List<Auction> getRandomAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    if (auctions.isEmpty || auctions.length <= 3) return [];

    List<Auction> randomAuctions = auctions
      ..removeRange(0, 3)
      ..shuffle()
      ..take(5);

    _randomAuctionsIds = randomAuctions.map((e) => e.id).toList();

    return randomAuctions;
  }

  List<Auction> getOtherAuction() {
    List<Auction> auctions = List.from(_auctions ?? []);

    if (auctions.isEmpty || auctions.length <= 8) return [];

    return auctions
      ..removeRange(0, 3)
      ..removeWhere((element) => (_randomAuctionsIds ?? []).contains(element.id));
  }
}
