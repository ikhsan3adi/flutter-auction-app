import 'package:auction_repository/src/models/models.dart';
import 'package:dio/dio.dart';

abstract class BidApiClient {
  Future<List<Bid>> getAuctionBids(String auctionId);
  Future<Bid> getBid(String id);
  Future<void> placeBid(Bid bid);
  Future<void> updateBid(Bid bid);
  Future<void> deleteBid(Bid bid);
}

class BidApiClientImpl extends BidApiClient {
  BidApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<Bid>> getAuctionBids(String auctionId) async {
    final response = await _dio.get('/auctions/$auctionId/bids');

    final List<dynamic> data = response.data['data'];
    final List<Bid> bids = data.map((json) => Bid.fromJson(json)).toList();
    return bids;
  }

  @override
  Future<Bid> getBid(String id) async {
    final response = await _dio.get('/bids/$id');

    final Bid bid = Bid.fromJson(response.data['data']);
    return bid;
  }

  @override
  Future<void> placeBid(Bid bid) async {
    await _dio.post(
      '/bids',
      data: bid.toJson(),
    );
  }

  @override
  Future<void> updateBid(Bid bid) async {
    await _dio.patch(
      '/bids',
      data: bid.toJson(),
    );
  }

  @override
  Future<void> deleteBid(Bid bid) async {
    await _dio.delete('/bids/${bid.id}');
  }
}
