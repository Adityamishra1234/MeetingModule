import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
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

  @override
  findNotes(String id) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findNotes}';

    var json = {'meeting_id': id};

    var res = await httpPost(url, json);

    return res;
    // TODO: implement findNotes
    // throw UnimplementedError();
  }

  // @override
  // addNotes(int meetingID, int noteType, String note, String createdBY,
  //     List<int> visibleToList) async {
  //   var url = '${Endpoints.baseUrl}${Endpoints.addNotes}';

  //   // var json = {
  //   //   "id": 1,
  //   //   "meeting_id": meetingID ,
  //   //   "note_type": 0,
  //   //   "note": "test",
  //   //   "is_active": true,
  //   //   "created_by": 142,
  //   //   "updated_by": 142,
  //   //   "created_at": "2023-05-09T09:04:55.000Z",
  //   //   "updated_at": "2023-05-16T10:55:31.000Z",
  //   //   "visible_to": "338",
  //   //   "is_added": true
  //   // };

  //   //    var json = {
  //   //   "id": "1",
  //   //   "meeting_id": "$meetingID",
  //   //   "note_type": "$noteType",
  //   //   "note": "$note",
  //   //   "is_active": "true",
  //   //   "created_by": "$createdBY",
  //   //   "updated_by": "$createdBY",
  //   //   "created_at": "${DateTime.now()}",
  //   //   "updated_at": "${DateTime.now()}",
  //   //   "visible_to": "${visibleToList.toString()}",
  //   //   "is_added": "true"
  //   // };

  //   var res = await httpPost(url, json);

  //   return res;
  //   // TODO: implement addNotes
  //   // throw UnimplementedError();
  // }

  @override
  addNotes(FindNotesModel model) async {
    var url = '${Endpoints.baseUrl}${Endpoints.addNotes}';
    print(model);

    // var json = await model.toJson();

    var data = json.encode(model);

    print(json);
    var res = await httpPost(url, data);

    print(res);
    // TODO: implement addNotes
    // throw UnimplementedError();
  }
}
