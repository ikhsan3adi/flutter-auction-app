import 'package:dio/dio.dart';

extension DioErrorX on DioError {
  List<String> get errorsMessages {
    if (response?.data == null || response?.data['messages'] == null) {
      return [(error ?? toString()).toString()];
    }

    final List<String> errors = (response?.data['messages'] as Map<String, dynamic>).cast<String, String>().values.toList();

    return errors;
  }
}
