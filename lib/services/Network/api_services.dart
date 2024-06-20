import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meeting_module2/services/endpoints.dart';

import 'api_exceptions.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  // static const host = "http://164.52.208.95:1716/";
  static String host = Endpoints.baseUrl;
  // static const host = "https://6378-125-63-100-67.ngrok-free.app/";

  static String _baseUrl = "${host}";

  dynamic postRequest(String subUrl, Map<String, dynamic> inputData,
      {bool withFile = false, bool cacheRequest = true,
        bool forceRefresh = false}) async {
    try {
      String url = "$_baseUrl$subUrl";

      debugPrint('---POST1 url $url');
      debugPrint('---Params $inputData');
      Options option = Options(
        contentType: Headers.formUrlEncodedContentType,
      );
      Response res = await dio.post(
        url,
        data: withFile ? FormData.fromMap(inputData) : inputData,
        options: option,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var rData = res.data;
        debugPrint('---RESULT: $rData');
        log("---RESULT1: $rData");
        debugPrint('---RESULT END');
        return rData;
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromString(dioError.response.toString());
    }
  }

  dynamic getRequest(String subUrl,
      {Map<String, dynamic> data = const {},
      bool cacheRequest = true,
      bool forceRefresh = false}) async {
    try {
      String url = "$_baseUrl$subUrl";

      debugPrint('---GET1 url $url');
      debugPrint('---Params $data');

      Options option = Options(
        // contentType: Headers.formUrlEncodedContentType,
        contentType: Headers.jsonContentType,
      );
      Response res = await dio.get(
        url,
        queryParameters: data,
        options: option,
      );
      debugPrint('---RESULT: ${res.data}');
      log("---RESULT1: ${res.data}");
      if (res.statusCode == 200) {
        var rData = res.data;
        debugPrint('---RESULT END');
        return rData;
      } else if (res.statusCode == 404) {
        var errorResponse = res.data['error'];
        throw ApiException.fromString("Error Occurred: $errorResponse");
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }

  dynamic putRequest(String subUrl, Map<String, dynamic> inputData,
      {bool withFile = false,
      bool cacheRequest = true,
      bool forceRefresh = false}) async {
    try {
      String url = "$_baseUrl$subUrl";

      debugPrint('---PUT url $url');
      debugPrint('---Params $inputData');
      Options option = Options(
        contentType: Headers.formUrlEncodedContentType,
      );
      Response res = await dio.put(
        url,
        data: withFile ? FormData.fromMap(inputData) : inputData,
        options: option,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var rData = res.data;
        debugPrint('---RESULT: $rData');
        log("---RESULT1: $rData");
        debugPrint('---RESULT END');
        return rData;
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }

  dynamic patchRequest(String subUrl, Map<String, dynamic> inputData,
      {bool withFile = false,
      /* bool requireToken=false,*/ bool cacheRequest = true,
      bool forceRefresh = false}) async {
    try {
      String url = "$_baseUrl$subUrl";

      debugPrint('---PATCH url $url');
      debugPrint('---Params $inputData');
      Options option = Options(
        contentType: Headers.formUrlEncodedContentType,
      );
      Response res = await dio.patch(
        url,
        data: withFile ? FormData.fromMap(inputData) : inputData,
        options: option,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        var rData = res.data;
        debugPrint('---RESULT: $rData');
        log("---RESULT1: $rData");
        debugPrint('---RESULT END');
        return rData;
      } else {
        throw ApiException.fromString("Error Occurred. ${res.statusCode}");
      }
    } on SocketException {
      throw ApiException.fromString("No Internet Connection!");
    } on DioException catch (dioError) {
      throw ApiException.fromDioError(dioError);
    }
  }
}
