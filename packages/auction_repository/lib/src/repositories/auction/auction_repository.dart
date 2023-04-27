import 'package:auction_repository/src/models/models.dart';
import 'auction_api.dart';
import 'package:equatable/equatable.dart';

class AuctionRepository extends Equatable {
  const AuctionRepository({
    required AuctionApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuctionApiClient _apiClient;

  Future<List<Auction>> getAuctions() async {
    final auctions = await _apiClient.getAuctions();
    return auctions;
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

  @override
  List<Object?> get props => [_apiClient];
}
