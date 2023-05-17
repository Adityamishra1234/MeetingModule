import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
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
    // print(DateTime.now());
    //  print(DateTime.now().isUtc);
    //   print(DateTime.now());
    model.id = 1;
    model.meetingId = 1;
    model.noteType = 1;
    model.isActive = true;
    model.createdBy = 142;
    model.updatedBy = 142;
    model.createdAt = "2023-05-09T09:04:55.000Z";
    model.updatedAt = "2023-05-09T09:04:55.000Z";
    model.isAdded = true;

    var data = json.encode(model);

    print(json);
    var res = await httpPostHeader(url, data);

    print(res);
    // TODO: implement addNotes
  }

  @override
  addMeeting() async {
    var url = '${Endpoints.baseUrl}${Endpoints.addMeeting}';
    // var data = json.encode(model);
    var modeldata = """{
        "id": 12,
        "meeting_type": "Internal Meeting",
        "meeting_with": "",
        "meeting_agenda": "Institute Partner Meet",
        "specific_purpose_of_the_meeting": "",
        "name_of_the_meeting": "xyzaa my testing",
        "date_of_meeting": "2023-04-27",
        "time_of_the_meeting": "17:20",
        "duration_of_meeting": "5 hours 4 minutes",
        "meeting_mode": true,
        "meeting_mode_type": "Zoom",
        "meeting_link": "test by aman",
        "location_of_the_meeting": "",
        "siec_branch": 0,
        "specific_location_of_the_meeting": "",
        "siec_participants": [
            {
                "name": "Kashish IT",
                "id": 136
            },
            {
                "name": "Shreya IT",
                "id": 107
            },
            {
                "name": "Taniya IT",
                "id": 338
            }
        ],
        "meeting_coordinator": [
            {
                "name": "Shreya IT",
                "id": 107
            },
            {
                "name": "Kashish IT",
                "id": 136
            }
        ],
        "meeting_started": true,
        "is_reschedule": false,
        "meeting_ended": true,
        "meeting_exceeded": false,
        "is_active": true,
        "created_by": 105,
        "updated_by": 105,
        "created_at": "2023-04-07T09:48:35.000Z",
        "updated_at": "2023-04-07T09:48:35.000Z",
        "meeting_started_time": null,
        "meeting_ended_time": null,
        "meeting_started_by": null,
        "meeting_ended_by": null
    }""";

    AllMeetings model = AllMeetings.fromJson(json.decode(modeldata));
    var data = json.encode(model);

    var res = await httpPostHeader(url, data);
    print(res);
  }
}
