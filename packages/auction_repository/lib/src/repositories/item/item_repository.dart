import 'package:auction_repository/src/models/models.dart';

import 'item_api.dart';

class ItemRepository {
  ItemRepository({required ItemApiClient apiClient}) : _apiClient = apiClient;

  final ItemApiClient _apiClient;

  Future<List<Item>> getItems() async {
    return await _apiClient.getItems();
  }

  Future<Item> getItem(String id) async {
    return await _apiClient.getItem(id);
  }

  Future<void> createItem(Item item) async {
    // TODO image upload
    return _apiClient.createItem(item);
  }

  Future<void> updateItem(Item item) async {
    // TODO image upload
    return _apiClient.updateItem(item);
  }

  Future<void> deleteItem(String id) async {
    return _apiClient.deleteItem(id);
  }
}
