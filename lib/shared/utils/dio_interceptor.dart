import 'package:dio/dio.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class AppInterceptors extends Interceptor {
  final Dio _dio;

  AppInterceptors({required Dio dio}) : _dio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.badCertificate:
      case DioErrorType.unknown:
        throw DioError;
      case DioErrorType.cancel:
        break;
    }

    return handler.next(err);
  }
}
