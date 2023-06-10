import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:meeting_module2/services/errors.dart';
import 'package:meeting_module2/utils/check_user_connection.dart';
import 'package:meeting_module2/utils/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:studentpanel/utils/constants.dart';
// import 'package:studentpanel/utils/endpoint.dart';

// import 'error.dart';

class BaseServices {
  // Api Call Base Method

  // getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString("token");
  //   return token;
  // }

  // httpGet(String url) async {
  //   await checkUserConnection();
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  httpPost(String url, jsonData) async {
    // String? token = await getToken();
    await checkUserConnection();
    // jsonData = jsonData.replaceAll('"null"', "");
    var response = await http.post(
      Uri.parse(url),
      body: jsonData,
    );

    switch (response.statusCode) {
      case 200:
        {
          var res = json.decode(response.body);
          if (res['success'] == true) {
            return res;
          } else {
            getToast(res['message']);
            return null;
          }
        }
      case 440:
        throw EmptyDataException("440");
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 502:
        throw InternetError("Please try after sometime");
      case 500:
      default:
        throw FetchDataException(
            'Something went to wrong : ${response.statusCode}');
    }
  }

  httpPostHeader(String url, jsonData) async {
    // String? token = await getToken();
    await checkUserConnection();
    // jsonData = jsonData.replaceAll('"null"', "");
    var response = await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {"Content-Type": "application/json"},
    );

    switch (response.statusCode) {
      case 200:
        {
          var res = json.decode(response.body);
          if (res['success'] == true) {
            return res;
          } else {
            getToast(res['message']);
            return null;
          }
        }

      case 440:
        throw EmptyDataException("440");
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 502:
        throw InternetError("Please try after sometime");
      case 500:
      default:
        throw FetchDataException(
            'Something went to wrong : ${response.statusCode}');
    }
  }
  //   httpPostHeader(String url, jsonData) async {
  //   // String? token = await getToken();
  //   await checkUserConnection();
  //   // jsonData = jsonData.replaceAll('"null"', "");
  //   var response = await http.post(
  //     Uri.parse(url),
  //     body: jsonData,
  //     headers: {"Content-Type": "application/json"},
  //   );

  //   switch (response.statusCode) {
  //     case 200:
  //       return response.body.isNotEmpty
  //           ? response.body
  //           : throw EmptyDataException("440");
  //     case 440:
  //       throw EmptyDataException("440");
  //     case 400:
  //       throw BadRequestException(response.body.toString());
  //     case 401:
  //     case 403:
  //       throw UnauthorisedException(response.body.toString());
  //     case 502:
  //       throw InternetError("Please try after sometime");
  //     case 500:
  //     default:
  //       throw FetchDataException(
  //           'Something went to wrong : ${response.statusCode}');
  //   }
  // }

  httpPostApplication(String url, jsonData) async {
    // String? token = await getToken();
    await checkUserConnection();

    // jsonData = jsonData.replaceAll('"null"', "");
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonData);

    switch (response.statusCode) {
      case 200:
        return response.body.isNotEmpty
            ? response.body
            : throw EmptyDataException("440");
      case 440:
        throw EmptyDataException("440");
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 502:
        throw InternetError("Please try after sometime");
      case 500:
      default:
        throw FetchDataException(
            'Something went to wrong : ${response.statusCode}');
    }
  }

  logoutPost(String url, var jsonData, String token) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            // "Accept": "application/json",
            // "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer $token',
          },
          body: jsonData);

      if (response.statusCode == 200) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // httpPostNullBody(String url, {bool login = false}) async {
  //   // String? token = await getToken();
  //   url = url.replaceAll('"null"', "");
  //   if (login == false) {
  //     await checkUserConnection();
  //   }

  //   var response = await http.post(
  //     Uri.parse(url),
  //   );
  //   switch (response.statusCode) {
  //     case 200:
  //       return response.body.isNotEmpty && response.body != ""
  //           ? response.body
  //           : throw EmptyDataException("440 :${response.body}");
  //     case 440:
  //       throw EmptyDataException("440 :${response.body}");
  //     case 400:
  //       throw BadRequestException("${response.statusCode} :${response.body}");
  //     case 401:
  //     case 403:
  //       throw UnauthorisedException("${response.statusCode} :${response.body}");
  //     case 502:
  //       throw InternetError("${response.statusCode} :${response.body}");
  //     case 500:
  //     default:
  //       throw FetchDataException("${response.statusCode} :${response.body}");
  //   }
  // }

  httpPostNullBody(String url, {bool login = false}) async {
    // String? token = await getToken();
    url = url.replaceAll('"null"', "");
    if (login == false) {
      await checkUserConnection();
    }

    var response = await http.post(
      Uri.parse(url),
    );
    switch (response.statusCode) {
      case 200:
        {
          var res = json.decode(response.body);
          if (res['success'] == true) {
            return res;
          } else {
            getToast(res['message']);
            return null;
          }
        }
      case 440:
        throw EmptyDataException("440 :${response.body}");
      case 400:
        throw BadRequestException("${response.statusCode} :${response.body}");
      case 401:
      case 403:
        throw UnauthorisedException("${response.statusCode} :${response.body}");
      case 502:
        throw InternetError("${response.statusCode} :${response.body}");
      case 500:
      default:
        throw FetchDataException("${response.statusCode} :${response.body}");
    }
  }

  httplogout(String url, String token) async {
    // String? token = await getToken();
    // await checkUserConnection();

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    print(token);
    print(response.body);

    switch (response.statusCode) {
      case 200:
        return response.body.isNotEmpty
            ? response.body
            : throw EmptyDataException("440");
      case 440:
        throw EmptyDataException("440");
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 502:
        throw InternetError("Please try after sometime");
      case 500:
      default:
        throw FetchDataException(
            'Something went to wrong : ${response.statusCode}');
    }
  }

  httpPut(String url, var jsonData) async {
    // String? token = await getToken();
    await checkUserConnection();
    try {
      var response = await http.put(Uri.parse(url), body: jsonData, headers: {
        "Accept": "application/json",
        // 'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  httpDelete(String url, var jsonData) async {
    // String? token = await getToken();
    await checkUserConnection();
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': 'Bearer $token'
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // errorHandle(String enq_id, String error_message, String statusCode,
  //     [String extra = ""]) async {
  //   String endpoint = Endpoints.errorHandlePart1! +
  //       enq_id +
  //       Endpoints.errorHandlepart2! +
  //       error_message +
  //       Endpoints.errorHandlepart3! +
  //       statusCode +
  //       Endpoints.errorHandlepart4! +
  //       extra.replaceAll("#", "");

  //   try {
  //     if (int.parse(statusCode) != 440) {
  //       var res = await httpPostNullBody(Endpoints.baseUrl! + endpoint);
  //       if (res != null) {
  //         print(res);
  //       }
  //     }
  //   } catch (e) {}
  // }
}
