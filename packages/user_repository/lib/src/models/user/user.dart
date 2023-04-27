import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String username;
  final String name;
  final String email;
  final String? phone;
  final String? profileImageUrl;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phone,
    required this.profileImageUrl,
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
