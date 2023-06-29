import 'package:auction_repository/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class ItemApiClient extends Equatable {
  Future<List<Item>> getItems();
  Future<Item> getItem(String id);
  Future<void> createItem(Item item);
  Future<void> updateItem(Item item, List<String> formerImageIds);
  Future<void> deleteItem(String id);
}

class ItemApiClientImpl extends ItemApiClient {
  ItemApiClientImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  List<Object?> get props => [_dio];

  @override
  Future<List<Item>> getItems() async {
    final response = await _dio.get('/items');

    final List<dynamic> data = response.data['data'];
    final List<Item> items = data.map((json) => Item.fromJson(json)).toList();
    return items;
  }

  @override
  Future<Item> getItem(String id) async {
    final response = await _dio.get('/items/$id');

    final Item item = Item.fromJson(response.data['data']);
    return item;
  }

  @override
  Future<void> createItem(Item item) async {
    FormData formData = FormData();

    for (ItemImage image in item.images) {
      formData.files.add(MapEntry(
        "images[]",
        await MultipartFile.fromFile(image.url, filename: image.url.split('/').last),
      ));
    }

    formData.fields.addAll(item.toJson().cast<String, String>().entries);

    await _dio.post(
      '/items',
      data: formData,
    );
  }

  @override
  Future<void> updateItem(Item item, List<String> formerImageIds) async {
    await _dio.patch(
      '/items/${item.id}',
      data: item.toJson(),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    FormData formData = FormData();

    if (item.images.isNotEmpty) {
      for (ItemImage image in item.images) {
        formData.files.add(MapEntry(
          "images[]",
          await MultipartFile.fromFile(image.url, filename: image.url.split('/').last),
        ));
      }
    }

    if (formerImageIds.isNotEmpty) {
      formData.fields.add(MapEntry('former_images_id', formerImageIds.toString()));
    }

    await _dio.post(
      '/items/${item.id}/images/update',
      data: formData,
    );
  }

  @override
  Future<void> deleteItem(String id) async {
    await _dio.delete('/items/$id');
  }
}
