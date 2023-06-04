import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class DioServices {
  static Dio createDio({required TokenRepository tokenRepository}) {
    final Token? token = tokenRepository.token;

    final String accessToken = token != null ? token.accessToken : 'Unknown';

    final Dio dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer $accessToken'},
      baseUrl: dotenv.get('API_BASE_URL'),
    ));

    dio.interceptors.add(AppInterceptors(dio: dio));

    return dio;
  }
}
