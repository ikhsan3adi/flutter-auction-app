import 'package:auction_repository/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class AuctionApiClient extends Equatable {
  Future<List<Auction>> getAuctions(int page);
  Future<Auction> getAuction(String id);
  Future<void> createAuction(Auction auction);
  Future<void> updateAuction(Auction auction);
  Future<void> deleteAuction(String id);

  Future<List<Auction>> getMyAuctions();
  Future<List<BidWithAuction>> getMyBidAuctions();

  Future<void> setAuctionWinner(String auctionId, Bid bid);
  Future<void> closeAuction(String auctionId);
}

class AuctionApiClientImpl extends AuctionApiClient {
  AuctionApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<Auction>> getAuctions(int page) async {
    final response = await _dio.get('/auctions', queryParameters: {'page': page});

    final List<dynamic> data = response.data['data'];
    final List<Auction> auctions = data.map((json) => Auction.fromJson(json)).toList();
    return auctions;
  }

  @override
  Future<Auction> getAuction(String id) async {
    final response = await _dio.get('/auctions/$id');

    final Auction auction = Auction.fromJson(response.data['data']);
    return auction;
  }

  @override
  Future<void> createAuction(Auction auction) async {
    await _dio.post(
      '/auctions',
      data: auction.toJson(),
    );
  }

  @override
  Future<void> updateAuction(Auction auction) async {
    await _dio.patch(
      '/auctions/${auction.id}',
      data: auction.toJson(),
    );
  }

  @override
  Future<void> deleteAuction(String id) async {
    await _dio.delete('/auctions/$id');
  }

  @override
  Future<List<Auction>> getMyAuctions() async {
    final response = await _dio.get('/users/auctions');

    final List<dynamic> data = response.data['data'];
    final List<Auction> auctions = data.map((json) => Auction.fromJson(json)).toList();
    return auctions;
  }

  @override
  Future<List<BidWithAuction>> getMyBidAuctions() async {
    final response = await _dio.get('/users/bids');

    final List<dynamic> data = response.data['data'];
    final List<BidWithAuction> auctionWithBids = data.map((json) => BidWithAuction.fromJson(json)).toList();
    return auctionWithBids;
  }

  @override
  Future<void> setAuctionWinner(String auctionId, Bid bid) async {
    await _dio.patch(
      '/auctions/$auctionId/winner',
      data: {'bidId': bid.id},
    );
  }

  @override
  Future<void> closeAuction(String auctionId) async {
    await _dio.patch('/auctions/$auctionId/close');
  }
}
