import 'package:auction_repository/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class AuctionApiClient extends Equatable {
  Future<List<Auction>> getAuctions();
  Future<Auction> getAuction(String id);
  Future<void> createAuction(Auction auction);
  Future<void> updateAuction(Auction auction);
  Future<void> deleteAuction(String id);
}

class OnlineAuctionApiClient extends AuctionApiClient {
  OnlineAuctionApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<Auction>> getAuctions() async {
    final response = await _dio.get('/auction');

    final List<dynamic> data = response.data['data'];
    final List<Auction> products = data.map((json) => Auction.fromJson(json)).toList();
    return products;
  }

  @override
  Future<Auction> getAuction(String id) async {
    final response = await _dio.get('/auction/$id');

    final Auction product = Auction.fromJson(response.data['data']);
    return product;
  }

  @override
  Future<void> createAuction(Auction auction) async {
    await _dio.post(
      '/auction',
      data: auction.toJson(),
    );
  }

  @override
  Future<void> updateAuction(Auction auction) async {
    await _dio.patch(
      '/auction/${auction.id}',
      data: auction.toJson(),
    );
  }

  @override
  Future<void> deleteAuction(String id) async {
    await _dio.delete('/auction/$id');
  }
}
