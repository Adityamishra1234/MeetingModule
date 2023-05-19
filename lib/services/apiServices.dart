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
  addMeeting(AllMeetings modelData) async {
    var url = '${Endpoints.baseUrl}${Endpoints.addMeeting}';
    // var data = json.encode(model);

    var modeldata = {
      "id": 12,
      "meeting_type": "${modelData.meetingType}",
      "meeting_with": "${modelData.meetingWith}",
      "meeting_agenda": "${modelData.meetingAgenda}",
      "specific_purpose_of_the_meeting":
          "${modelData.specificPurposeOfTheMeeting}",
      "name_of_the_meeting": "${modelData.nameOfTheMeeting}",
      "date_of_meeting": "${modelData.dateOfMeeting}",
      "time_of_the_meeting": "${modelData.timeOfTheMeeting}",
      "duration_of_meeting": "${modelData.durationOfMeeting}",
      "meeting_mode": modelData.meetingMode,
      "meeting_mode_type": "${modelData.meetingModeType}",
      "meeting_link": "${modelData.meetingLink}",
      "location_of_the_meeting": "${modelData.locationOfTheMeeting}",
      "siec_branch": modelData.siecBranch,
      "specific_location_of_the_meeting":
          "${modelData.specificLocationOfTheMeeting}",
      "siec_participants": modelData.siecParticipants!
          .map((e) => {'name': e.name, 'id': e.id})
          .toList(),
      "meeting_coordinator": modelData.meetingCoordinator!
          .map((e) => {'name': e.name, 'id': e.id})
          .toList(),
      "meeting_started": modelData.meetingStarted,
      "is_reschedule": modelData.isReschedule,
      "meeting_ended": modelData.meetingEnded,
      "meeting_exceeded": modelData.meetingExceeded,
      "is_active": modelData.isActive,
      "created_by": modelData.createdBy,
      "updated_by": modelData.updatedBy,
      "created_at": "${modelData.createdAt}",
      "updated_at": "${modelData.updatedAt}",
      "meeting_started_time": null,
      "meeting_ended_time": null,
      "meeting_started_by": null,
      "meeting_ended_by": null
    };

    AllMeetings model = AllMeetings.fromJson(modeldata);
    var data = json.encode(model);

    var res = await httpPostHeader(url, data);
    print(res);
  }

  @override
  createMeeting(AllMeetings model) async {
    var url = '${Endpoints.baseUrl}${Endpoints.addMeeting}';

    var jsonData = json.encode(model);
    print(jsonData);

    // TODO: implement createInternalMeeting

    var res = await httpPostApplication(url, jsonData);
  }

  @override
  selectedAudienceType() async {
    var url = '${Endpoints.baseUrl}${Endpoints.selectedAudienceType}';

    var res2 = await httpPostNullBody(url);

    var res = jsonDecode(res2);

    return res;

    // TODO: implement selectedAudienceType
    // throw UnimplementedError();
  }

  @override
  allBranch() async {
    var url = '${Endpoints.baseUrl}${Endpoints.allBranch}';

    var res2 = await httpPostNullBody(url);

    var res = jsonDecode(res2);

    return res;
    // TODO: implement allBranch
    // throw UnimplementedError();
  }

  @override
  getSpecificBranchUsers(int branchCode) async {
    var url = '${Endpoints.baseUrl}${Endpoints.specificBranchUsers}';

    var jsonData = {'branch_id': branchCode};

    var datas = json.encode(jsonData);
    var res2 = await httpPostHeader(url, datas);

    var res = jsonDecode(res2);

    return res;

    // TODO: implement getSpecificBranchUsers
    //
    //throw UnimplementedError();
  }

  @override
  getAllUniversity(int countryCode) async {
    var url = '${Endpoints.baseUrl}${Endpoints.universtiyByCountry}';

    var jsonData = {'country_id': countryCode};

    var datas = json.encode(jsonData);
    var res2 = await httpPostHeader(url, datas);

    var res = jsonDecode(res2);

    return res;

    // TODO: implement getAllUniversity
  }

  @override
  getAllCountries() async {
    var url = '${Endpoints.baseUrl}${Endpoints.allCountry}';

    // var jsonData = {'country_id': countryCode};

    // var datas = json.encode(jsonData);
    var res2 = await httpPostNullBody(url);

    var res = jsonDecode(res2);

    return res;
    // TODO: implement getAllCountries
    // throw UnimplementedError();
  }
}
