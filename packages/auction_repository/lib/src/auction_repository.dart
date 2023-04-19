import 'package:auction_api/auction_api.dart';

class AuctionRepository {
  AuctionRepository({
    required AuctionApi auctionApi,
  }) : _auctionApi = auctionApi;

  final AuctionApi _auctionApi;
}
