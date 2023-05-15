import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/services/api.dart';
import 'package:meeting_module2/services/base_services.dart';
import 'package:meeting_module2/services/endpoints.dart';

class ApiServices extends BaseServices implements API {
  @override
  getAllMeetings() {
    var url = '${Endpoints.baseUrl}${Endpoints.allMeetings}';

    var res = httpPostNullBody(url);

    // var resdata = jsonDecode(res);

    // print(res);
    return res;

    // TODO: implement getAllMeetings
    // throw UnimplementedError();
  }

  @override
  getAllUsers() {
    var url = '${Endpoints.baseUrl}${Endpoints.allUser}';

    var res = httpPostNullBody(url);

    return res;

    // TODO: implement getAllUsers
    // throw UnimplementedError();
  }
}
