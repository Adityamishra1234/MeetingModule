import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/services/api.dart';
import 'package:meeting_module2/services/base_services.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:tuple/tuple.dart';

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
  getDropdown(String endpoint) async {
    var url = '${Endpoints.baseUrl}${endpoint}';
    var res = await httpPostNullBody(url);
    if (res != null) {
      return res;
    }
  }
}
