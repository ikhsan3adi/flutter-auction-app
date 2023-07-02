import 'package:dio/dio.dart';

class CustomDioException extends DioError {
  CustomDioException({
    required RequestOptions requestOptions,
    Response? response,
  }) : super(requestOptions: requestOptions, response: response);
}

class BadRequestException extends CustomDioException {
  BadRequestException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends CustomDioException {
  InternalServerErrorException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends CustomDioException {
  ConflictException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends CustomDioException {
  UnauthorizedException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends CustomDioException {
  NotFoundException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends CustomDioException {
  NoInternetConnectionException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends CustomDioException {
  DeadlineExceededException({required super.requestOptions, super.response});

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
