import 'package:auction_repository/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ItemApiClient extends Equatable {
  Future<List<Item>> getItems();
  Future<Item> getItem(String id);
  Future<void> createItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String id);
}

class ItemApiClientImpl extends ItemApiClient {
  ItemApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<Item>> getItems() async {
    final response = await _dio.get('/item');

    final List<dynamic> data = response.data['data'];
    final List<Item> items = data.map((json) => Item.fromJson(json)).toList();
    return items;
  }

  @override
  Future<Item> getItem(String id) async {
    final response = await _dio.get('/item/$id');

    final Item item = Item.fromJson(response.data['data']);
    return item;
  }

  @override
  Future<void> createItem(Item item) async {
    await _dio.post(
      '/item',
      data: item.toJson(),
    );
    // TODO handle image uploading
  }

  @override
  Future<void> updateItem(Item item) async {
    await _dio.patch(
      '/item/${item.id}',
      data: item.toJson(),
    );
    // TODO handle image uploading
  }

  @override
  Future<void> deleteItem(String id) async {
    await _dio.delete('/item/$id');
  }
}
