import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_image.g.dart';

@JsonSerializable()
class ItemImage extends Equatable {
  const ItemImage({this.id, required this.url});

  @JsonKey(name: 'image_id')
  final String? id;
  @JsonKey(name: 'image')
  final String url;

  factory ItemImage.fromJson(Map<String, dynamic> json) => _$ItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$ItemImageToJson(this);

  @override
  List<Object?> get props => [id, url];
}
