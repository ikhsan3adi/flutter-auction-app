import 'package:equatable/equatable.dart';

class Penawaran extends Equatable {
  final int id;
  final String username;
  final String name;
  final int hargaPenawaran;
  final DateTime waktuPenawaran;
  final String imageUrl;
  final bool mine;

  const Penawaran({
    required this.id,
    required this.username,
    required this.name,
    required this.hargaPenawaran,
    required this.waktuPenawaran,
    required this.imageUrl,
    required this.mine,
  });

  factory Penawaran.fromJson(Map<String, dynamic> json) => _$PenawaranFromJson(json);

  Map<String, dynamic> toJson() => _$PenawaranToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        hargaPenawaran,
        waktuPenawaran,
        imageUrl,
        mine,
      ];
}

Penawaran _$PenawaranFromJson(Map<String, dynamic> json) {
  return Penawaran(
    id: json['id'] as int,
    username: json['username'] as String,
    name: json['name'] as String,
    hargaPenawaran: json['hargaPenawaran'] as int,
    waktuPenawaran: DateTime.parse(json['waktuPenawaran'] as String),
    imageUrl: json['imageUrl'] as String,
    mine: json['mine'] as bool,
  );
}

Map<String, dynamic> _$PenawaranToJson(Penawaran instance) {
  return <String, dynamic>{
    'id': instance.id,
    'username': instance.username,
    'name': instance.name,
    'hargaPenawaran': instance.hargaPenawaran,
    'waktuPenawaran': instance.waktuPenawaran.toIso8601String(),
    'imageUrl': instance.imageUrl,
    'mine': instance.mine,
  };
}
