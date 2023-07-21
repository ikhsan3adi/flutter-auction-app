import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class DioServices {
  DioServices({required TokenRepository tokenRepository}) : _dio = DioServices.createDio(tokenRepository: tokenRepository);

  final Dio _dio;

  Dio getDio() => _dio;

  void addAccessToken({required String accessToken}) {
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  void deleteAccessToken() => _dio.options.headers['Authorization'] = null;

  static Dio createDio({required TokenRepository tokenRepository}) {
    final Token? token = tokenRepository.getToken();

    final String accessToken = token != null ? token.accessToken : 'Unknown';

    final Dio dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer $accessToken'},
      baseUrl: dotenv.get('API_BASE_URL'),
      receiveDataWhenStatusError: true,
    ));

    dio.interceptors.add(AppInterceptors(dio: dio));

    return dio;
  }
}
