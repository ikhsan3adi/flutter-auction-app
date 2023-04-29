import 'package:dio/dio.dart';

extension DioErrorX on DioError {
  List<String> get errorsMessages {
    if (requestOptions.data == null || requestOptions.data['messages'] == null) {
      return [toString()];
    }

    final List<String> errors = (requestOptions.data['messages'] as Map<String, String>).values.toList();

    return errors;
  }
}
