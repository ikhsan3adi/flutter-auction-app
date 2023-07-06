import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  @JsonKey(name: 'user_id')
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  @JsonKey(name: 'profile_image')
  final String? profileImageUrl;

  const User({
    this.id = 'user',
    required this.username,
    required this.email,
    required this.name,
    this.phone,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        name,
        phone,
        profileImageUrl,
      ];
}
