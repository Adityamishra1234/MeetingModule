import 'package:dio/dio.dart';

class ApiException implements Exception {
  static const networkMessage = "Connection to API server failed due to internet connection";
  ApiException.fromDioError(DioException dioError) {
    print("Error calling url: ${dioError.requestOptions.path} - ${dioError.error.toString()}");
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = networkMessage;
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response!.statusCode,dioError.response?.data["message"]);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  ApiException.fromString(String errorMsg) {
    message = errorMsg;
  }

  String message = '';

  String _handleError(int? statusCode, [String? msg]) {
    switch (statusCode) {
      case 400:
        return msg ?? 'Bad request';
      case 401:
        return msg ?? 'Bad request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong on server';
    }
  }

  @override
  String toString() => message;
}