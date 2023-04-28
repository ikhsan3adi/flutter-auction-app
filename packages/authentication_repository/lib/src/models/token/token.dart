import 'package:hive/hive.dart';

part 'token.g.dart';

@HiveType(typeId: 0)
class Token {
  Token({
    required this.accessToken,
    required this.expiresIn,
  });

  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final int expiresIn;

  @override
  String toString() {
    return 'Token {accessToken: $accessToken, expiresIn: $expiresIn}';
  }
}
