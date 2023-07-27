import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/participantsModel.dart';
import 'package:meeting_module2/services/api.dart';
import 'package:meeting_module2/services/base_services.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:meeting_module2/utils/theme.dart';

class ApiServices extends BaseServices implements API {
/////Auth APIS
  @override
  getEmailverification(String email) async {
    var url =
        '${Endpoints.baseUrl}${Endpoints.emailverification + "/${email}"}';
    var res2 = await httpPostNullBody(url);

    if (res2 != null) {
      return res2;
    }
  }

  @override
  getOTP(String email) async {
    var url = '${Endpoints.baseUrl}${Endpoints.otp + "/${email}"}';
    var res2 = await httpPostNullBody(url);
    if (res2 != null) {
      var res = jsonDecode(res2);
      return res;
    }
  }

  @override
  otpMatch(String email, String otp) async {
    var url =
        '${Endpoints.baseUrl}${Endpoints.otpMatch + "/${email}" + "/${otp}"}';
    var res2 = await httpPostNullBody(url);
    if (res2 != null) {
      var res = jsonDecode(res2);
      return res;
    }
  }

  @override
  password(String email, String password) async {
    var url = '${Endpoints.baseUrl}${Endpoints.passwordUpdate}';
    var data = {"email": "${email}", "password": '$password'};

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);
    if (res != null) {
      return res;
    }
  }

  @override
  login({required String email, required String password}) async {
    var url = '${Endpoints.baseUrl}${Endpoints.login}';

    var data = {
      "email": "${email}",
      "password": "$password",
    };

    var data2 = json.encode(data);

    var decoded = await httpPostHeader(url, data2);

    if (decoded != null) {
      return decoded['user'];
    }
  }

  @override
  getAllMeetings(int id) async {
    var url = '${Endpoints.baseUrl}${Endpoints.allMeetings}/$id';

    var res = await httpPostNullBody(url);

    if (res != []) {
      return res['meetingModel'];
    }

    // var resdata = jsonDecode(res);

    // print(res);

    // TODO: implement getAllMeetings
    // throw UnimplementedError();
  }

  @override
  getDropdown(String endpoint) async {
    var url = '${Endpoints.baseUrl}${endpoint}';
    var res = await httpPostNullBody(url);
    print(res);
    if (res != null) {
      return res['userList'];
    }
    // throw UnimplementedError();
  }

  @override
  findNotes(String id) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findNotes}';

    var json = {'meeting_id': id};

    var res = await httpPost(url, json);

    return res['model'];
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

    model.id = 1;
    model.meetingId = model.meetingId;
    model.noteType = model.noteType;
    model.isActive = true;
    model.createdBy = 142;
    model.updatedBy = 142;
    // model.createdAt = "2023-05-09T09:04:55.000Z";
    // model.updatedAt = "2023-05-09T09:04:55.000Z";
    model.isAdded = true;

    var data = json.encode(model);

    print(json);
    var res = await httpPostHeader(url, data);
    if (res != null) {
      return FindNotesModel.fromJson(res['model']);
    }
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
    return res['result'];
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

    return res2['userList'];

    // TODO: implement selectedAudienceType
    // throw UnimplementedError();
  }

  @override
  allBranch() async {
    var url = '${Endpoints.baseUrl}${Endpoints.allBranch}';

    var res2 = await httpPostNullBody(url);

    return res2['userListSend'];
    // TODO: implement allBranch
    // throw UnimplementedError();
  }

  @override
  getSpecificBranchUsers(int branchCode) async {
    var url = '${Endpoints.baseUrl}${Endpoints.specificBranchUsers}';

    var jsonData = {'branch_id': branchCode};

    var datas = json.encode(jsonData);
    var res2 = await httpPostHeader(url, datas);

    var res = res2['userListSend'];

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

    return res2['userListSend'];

    // TODO: implement getAllUniversity
  }

  @override
  getAllCountries() async {
    var url = '${Endpoints.baseUrl}${Endpoints.allCountry}';

    // var jsonData = {'country_id': countryCode};

    // var datas = json.encode(jsonData);
    var res2 = await httpPostNullBody(url);

    return res2['userListSend'];
    // TODO: implement getAllCountries
    // throw UnimplementedError();
  }

  @override
  addRepresentative(RepresentativeModel model) async {
    var url = '${Endpoints.baseUrl}${Endpoints.addRepresentative}';

    var modelData = {
      "id": 3,
      "representative_type": "${model.representativeType}",
      "person_name": "${model.personName}",
      "designation": "${model.designation}",
      "email": "${model.email}",
      "phone": model.phone,
      "country": model.country,
      "university": model.university,
      "vendor_name": "${model.vendorName}",
      "bank_name": "${model.bankName}",
      "is_active": model.isActive,
      "created_by": model.createdBy,
      "updated_by": model.updatedBy,
      "created_at": "",
      "updated_at": ""
    };

    RepresentativeModel data2 = RepresentativeModel.fromJson(modelData);
    var data = json.encode(data2);

    var res = await httpPostHeader(url, data);

    print(res);

    // TODO: implement addRepresentative
    // throw UnimplementedError();
  }

  @override
  findRepresentative(String representaiveType) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findRepresentative}';

    var data = {"findRepresentative": representaiveType};

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    print(res);

    // TODO:
    // implement findRepresentative
    // throw UnimplementedError();
  }

  @override
  findRepresentativeForDropDown(String representaiveType) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findRepresentativeForDropDown}';

    var data = {"representative_type": representaiveType};

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    return res['userListSend'];

    // TODO: implement findRepresentativeForDropDown
    // throw UnimplementedError();
  }

  @override
  getRepresentativeAllData(int id) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findRepresentativeByID}';

    var data = {"id": id};

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    return res['user'];

    // TODO: implement getRepresentativeAllData
    // throw UnimplementedError();
  }

  @override
  getRepresentativeByUniversity(
      {required String type,
      required int collegecode,
      required int countrycode}) async {
    var url =
        '${Endpoints.baseUrl}${Endpoints.findRepresentativeForUniversity}';

    var data = {
      "representative_type": "${type}",
      "country": countrycode,
      "university": collegecode
    };

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    return res['tempUser'];

    // TODO: implement getRepresentativeByUniversity
    // throw UnimplementedError();
  }

  @override
  addParticipants(List<ParticipantsModel> model) async {
    var url = '${Endpoints.baseUrl}${Endpoints.addParticipants}';

    // var data = {
    //   "id": null,
    //   "meeting_id": model.meetingId,
    //   "participant_id": model.participantId,
    //   "is_active": true,
    //   "created_by": 136,
    //   "updated_by": 136,
    //   "created_at": null,
    //   "updated_at": null
    // };

    var data2 = json.encode(model);

    var res = await httpPostHeader(url, data2);
    print(res);
    return res;

    // TODO: implement addParticipants
    // throw UnimplementedError();
  }

  @override
  resheduleMeeting(data) async {
    // TODO: implement resheduleMeeting
    var url = '${Endpoints.baseUrl}${Endpoints.resheduleMeeting}';

    var deta = json.encode(data);

    var res = await httpPostHeader(url, deta);

    if (res != null) {
      return res['meetingModel'];
    }

    // print(deta);
    // throw UnimplementedError();
  }

  @override
  meetingStartedOrEnded(int meetingId, int userId, int type, bool val) async {
    var url = '${Endpoints.baseUrl}${Endpoints.meetingStartedOrEnded}';

    var deta = {"meetingId": meetingId, "startedBy": userId, "type": val};

    var data = json.encode(deta);

    if (type == 0) {
      var res = await httpPostApplication(url, data);
      print(res);
    } else {
      print(data);
      var url2 = '${Endpoints.baseUrl}${Endpoints.meetingEnded}';

      var res = await httpPostApplication(url2, data);
      print(res);
    }

    // TODO: implement meetingStartedOrEnded
    // throw UnimplementedError();
  }

  @override
  findParticipantByMeetingId(int meetingId) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findMeetingParticipants}';
    var deta = {"meeting_id": meetingId};

    var data = json.encode(deta);

    var res = await httpPostHeader(url, data);

    return res['model'];
    // TODO: implement findParticipantByMeetingId
    // throw UnimplementedError();
  }

  @override
  assignTo(data) async {
    var url = '${Endpoints.baseUrl}${Endpoints.assignTo}';

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    print(res);

    // if (res == 'assignTo Sucessfully') {
    //   Get.defaultDialog(
    //       content: Container(
    //     child: Column(children: [
    //       Text('Assigned Successfully'),
    //       Icon(
    //         Icons.check,
    //         color: ThemeConstants.GreenColor,
    //         size: 25,
    //       )
    //     ]),
    //   ));
    // }

    // TODO: implement assignTo
    // throw UnimplementedError();
  }

  @override
  updateFCMToken(id, token) async {
    var url = '${Endpoints.baseUrl}${Endpoints.uodateFCMToken}';

    if (Platform.isAndroid) {
      var data = {"fcm_token_android": "$token", "id": '$id'};

      var data2 = await json.encode(data);

      var res = await httpPostApplication(url, data2);
    } else {
      var data = {"fcm_token_ios": "$token", "id": '$id'};

      var data2 = await json.encode(data);

      var res = await httpPostApplication(url, data2);
    }

    // print(res);

    // TODO: implement updateFCMToken
    // throw UnimplementedError();
  }

  @override
  findNoteByUser(id) async {
    var url = '${Endpoints.baseUrl}${Endpoints.findNoteByUser}/$id';

    // var data = {"fcm_token_android": "$token", "id": '$id'};

    // var data2 = await json.encode(data);

    var res = await httpPostNullBody(url);

    return res['model'];
    // TODO: implement findNoteByUser
    // throw UnimplementedError();
  }

  @override
  markAttendance(meetingId, userId, createdBY) async {
    // TODO: implement markAttendance
    var url = '${Endpoints.baseUrl}${Endpoints.userAttendance}';
    var data = {
      "id": 9,
      "meeting_id": meetingId,
      "user_id": userId,
      "start_time": "2023-06-05T09:57:34.000Z",
      "end_time": "2023-06-05T11:57:34.000Z",
      "is_active": true,
      "created_by": createdBY,
      "updated_by": createdBY,
      "created_at": "2023-06-05T09:57:34.000Z",
      "updated_at": "2023-06-05T09:57:34.000Z"
    };

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    print(res);

    // throw UnimplementedError();
  }

  @override
  reasonOfNotAttending(int meetningID, int createdBy, String reason) async {
    var url = '${Endpoints.baseUrl}${Endpoints.reasonOfNotAttending}';
    var data = {
      "id": 121,
      "meeting_id": meetningID,
      "meeting_notes_id": 0,
      "task_type": "Meeting Notes Task",
      "deadline_date": "2023-04-27",
      "task_owner_id": 136,
      "is_active": true,
      "closed_at": "2023-04-07T09:48:35.000Z",
      "closed_by": 0,
      "meeting_attented": false,
      "reason_of_not_attended": "$reason",
      "created_by": createdBy,
      "updated_by": createdBy,
      "created_at": "2023-04-07T09:48:35.000Z",
      "updated_at": "2023-04-07T09:48:35.000Z",
      "notes": "sacdcdcdc88c8dcda"
    };

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);

    print(res);
    // TODO: implement reasonOfNotAttending
    // throw UnimplementedError();
  }

  @override
  reasonOfNotAttendingAll(int meetningID) async {
    var url = '${Endpoints.baseUrl}${Endpoints.reasonOfNotAttendingAll}';
    var data = {"meeting_id": meetningID};

    var data2 = json.encode(data);

    var res = await httpPostHeader(url, data2);
    print(res);
    return res['model'];

    print(res);
  }

  @override
  findUniversityCountryByMeetingId(meetningID) async {
    try {
      var url =
          '${Endpoints.baseUrl}${Endpoints.findUniversityCountryByMeetingId}';
      var data = {"meeting_id": meetningID};

      var data2 = json.encode(data);

      var res = await httpPostHeader(url, data2);
      print(res);
      return res['model'];
    } catch (e) {
      throw UnimplementedError();
    }
    // TODO: implement findUniversityCountryByMeetingId
  }

  @override
  encryptNote(note, password) async {
    // TODO: implement encryptNote
    try {
      var url = '${Endpoints.baseUrl}${Endpoints.encrypt}';
      var data = {"password": password, "text": note};

      var data2 = json.encode(data);

      var res = await httpPostHeader(url, data2);
      print(res);
      print(res['temp']['encryptedText']);
      return res['temp']['encryptedText'];
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  decryptNote(note, password) async {
    try {
      var url = '${Endpoints.baseUrl}${Endpoints.decrypt}';
      var data = {"password": password, "text": note};

      var data2 = json.encode(data);

      var res = await httpPostHeader(url, data2);
      print(res);
      print(res['temp']);
      return res['temp'];
    } catch (e) {
      throw UnimplementedError();
    }
    // TODO: implement decryptNote
    // throw UnimplementedError();
  }
}
