import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("token");
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null &&
        err.response?.statusCode != null &&
        err.response?.statusCode == 401) {
    }
    debugPrint('error response: ${err.response}');
    return handler.next(err);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}