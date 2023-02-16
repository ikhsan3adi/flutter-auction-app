import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

enum StatusLelang {
  dibuka,
  ditutup,
}

@JsonSerializable()
class Lelang extends Equatable {
  final int id;
  final String namaBarang;
  final String deskripsiBarang;
  final DateTime waktuMulai;
  final DateTime waktuSelesai;
  final int hargaAwal;
  final int? hargaAkhir;
  final String? namaPemenang;
  final String? usernamePemenang;
  final String namaPetugas;
  final StatusLelang status;
  final List<String> imageUrls;

  const Lelang({
    required this.id,
    required this.namaBarang,
    required this.deskripsiBarang,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.hargaAwal,
    required this.hargaAkhir,
    required this.namaPemenang,
    required this.usernamePemenang,
    required this.namaPetugas,
    required this.status,
    required this.imageUrls,
  });

  factory Lelang.fromJson(Map<String, dynamic> json) => _$LelangFromJson(json);

  Map<String, dynamic> toJson() => _$LelangToJson(this);

  @override
  List<Object?> get props => [
        id,
        namaBarang,
        deskripsiBarang,
        waktuMulai,
        waktuSelesai,
        hargaAwal,
        hargaAkhir,
        namaPemenang,
        usernamePemenang,
        namaPetugas,
        status,
        imageUrls,
      ];

  static List<Lelang> dummyLelang = [
    Lelang(
      id: 0,
      namaBarang: "Mercusys MW302R",
      deskripsiBarang:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Scelerisque purus semper eget duis at. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Et tortor consequat id porta nibh venenatis cras. Nisl purus in mollis nunc sed id semper risus in. Pellentesque dignissim enim sit amet venenatis urna cursus eget nunc. Turpis tincidunt id aliquet risus feugiat in ante metus. Et malesuada fames ac turpis egestas sed tempus urna et. At quis risus sed vulputate.",
      waktuMulai: DateTime.parse("2022-11-16 09:00:00"),
      waktuSelesai: DateTime.parse("2023-03-16 09:00:00"),
      hargaAwal: 120000,
      hargaAkhir: null,
      namaPemenang: null,
      usernamePemenang: null,
      namaPetugas: "Super Admin",
      status: StatusLelang.dibuka,
      imageUrls: const [
        "https://gambar.com",
        "https://gambar.com",
        "https://gambar.com",
      ],
    ),
    Lelang(
      id: 1,
      namaBarang: "RK100",
      deskripsiBarang:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Scelerisque purus semper eget duis at. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Et tortor consequat id porta nibh venenatis cras. Nisl purus in mollis nunc sed id semper risus in. Pellentesque dignissim enim sit amet venenatis urna cursus eget nunc. Turpis tincidunt id aliquet risus feugiat in ante metus. Et malesuada fames ac turpis egestas sed tempus urna et. At quis risus sed vulputate.",
      waktuMulai: DateTime.parse("2022-10-16 09:00:00"),
      waktuSelesai: DateTime.parse("2023-12-16 09:00:00"),
      hargaAwal: 120000,
      hargaAkhir: null,
      namaPemenang: null,
      usernamePemenang: null,
      namaPetugas: "Super Admin",
      status: StatusLelang.dibuka,
      imageUrls: const [
        "https://gambar.com",
        "https://gambar.com",
        "https://gambar.com",
      ],
    ),
    Lelang(
      id: 2,
      namaBarang: "Sale pisang arum sari",
      deskripsiBarang:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Scelerisque purus semper eget duis at. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. Et tortor consequat id porta nibh venenatis cras. Nisl purus in mollis nunc sed id semper risus in. Pellentesque dignissim enim sit amet venenatis urna cursus eget nunc. Turpis tincidunt id aliquet risus feugiat in ante metus. Et malesuada fames ac turpis egestas sed tempus urna et. At quis risus sed vulputate.",
      waktuMulai: DateTime.parse("2022-11-16 09:00:00"),
      waktuSelesai: DateTime.parse("2023-04-16 09:00:00"),
      hargaAwal: 120000,
      hargaAkhir: null,
      namaPemenang: null,
      usernamePemenang: null,
      namaPetugas: "Ikhsan S",
      status: StatusLelang.dibuka,
      imageUrls: const [
        "https://gambar.com",
        "https://gambar.com",
        "https://gambar.com",
      ],
    ),
  ];
}

Lelang _$LelangFromJson(Map<String, dynamic> json) {
  return Lelang(
    id: json['id'] as int,
    namaBarang: json['namaBarang'] as String,
    deskripsiBarang: json['deskripsiBarang'] as String,
    waktuMulai: DateTime.parse(json['waktuMulai'] as String),
    waktuSelesai: DateTime.parse(json['waktuSelesai'] as String),
    hargaAwal: json['hargaAwal'] as int,
    hargaAkhir: json['hargaAkhir'] as int?,
    namaPemenang: json['namaPemenang'] as String?,
    usernamePemenang: json['usernamePemenang'] as String?,
    namaPetugas: json['namaPetugas'] as String,
    status: $enumDecode(_$StatusLelangEnumMap, json['status']),
    imageUrls: (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$LelangToJson(Lelang instance) {
  return <String, dynamic>{
    'id': instance.id,
    'namaBarang': instance.namaBarang,
    'deskripsiBarang': instance.deskripsiBarang,
    'waktuMulai': instance.waktuMulai.toIso8601String(),
    'waktuSelesai': instance.waktuSelesai.toIso8601String(),
    'hargaAwal': instance.hargaAwal,
    'hargaAkhir': instance.hargaAkhir,
    'namaPemenang': instance.namaPemenang,
    'usernamePemenang': instance.usernamePemenang,
    'namaPetugas': instance.namaPetugas,
    'status': _$StatusLelangEnumMap[instance.status]!,
    'imageUrls': instance.imageUrls,
  };
}

const _$StatusLelangEnumMap = {
  StatusLelang.dibuka: 'dibuka',
  StatusLelang.ditutup: 'ditutup',
};
