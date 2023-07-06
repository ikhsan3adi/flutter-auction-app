import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'token.g.dart';

@HiveType(typeId: 0)
class Token {
  Token({
    required this.accessToken,
    this.expiresIn,
    this.tokenTime,
    this.userData,
  });

  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final DateTime? expiresIn;
  @HiveField(2)
  final DateTime? tokenTime;
  @HiveField(3)
  final User? userData;

  @override
  String toString() {
    return 'Token {accessToken: $accessToken, expiresIn: $expiresIn, tokenTime: $tokenTime, userData: ${userData?.toJson()}}';
  }

  User getUserInfo() => User.fromJson(JwtDecoder.decode(accessToken));

  factory Token.fromEncodedToken({required String token}) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return Token(
      accessToken: token,
      expiresIn: JwtDecoder.getExpirationDate(token),
      tokenTime: DateTime.now().subtract(JwtDecoder.getTokenTime(token)),
      userData: User.fromJson(decodedToken..addEntries({'id': Uuid().v4()}.entries)),
    );
  }

  Token copyWith({
    String? accessToken,
    DateTime? expiresIn,
    DateTime? tokenTime,
    User? userData,
  }) {
    return Token(
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenTime: tokenTime ?? this.tokenTime,
      userData: userData ?? this.userData,
    );
  }
}
