import 'package:dio/dio.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class CustomDioException extends DioError {
  CustomDioException(RequestOptions r) : super(requestOptions: r);

  List<String> errors() {
    if (errorsMessages().isEmpty) {
      return errorsMessages()..insert(0, toString());
    }
    return errorsMessages();
  }
}

class BadRequestException extends CustomDioException {
  BadRequestException(super.r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends CustomDioException {
  InternalServerErrorException(super.r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends CustomDioException {
  ConflictException(super.r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends CustomDioException {
  UnauthorizedException(super.r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends CustomDioException {
  NotFoundException(super.r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends CustomDioException {
  NoInternetConnectionException(super.r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends CustomDioException {
  DeadlineExceededException(super.r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
