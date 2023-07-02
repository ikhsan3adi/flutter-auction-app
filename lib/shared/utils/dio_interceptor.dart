import 'package:dio/dio.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors({required Dio dio});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(requestOptions: err.requestOptions, response: err.response);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(requestOptions: err.requestOptions, response: err.response);
          case 401:
            throw UnauthorizedException(requestOptions: err.requestOptions, response: err.response);
          case 404:
            throw NotFoundException(requestOptions: err.requestOptions, response: err.response);
          case 409:
            throw ConflictException(requestOptions: err.requestOptions, response: err.response);
          case 500:
            throw InternalServerErrorException(requestOptions: err.requestOptions, response: err.response);
        }
        break;
      case DioErrorType.connectionError:
        throw NoInternetConnectionException(requestOptions: err.requestOptions, response: err.response);
      case DioErrorType.badCertificate:
      case DioErrorType.unknown:
        throw DioError;
      case DioErrorType.cancel:
        break;
    }

    return handler.next(err);
  }
}
