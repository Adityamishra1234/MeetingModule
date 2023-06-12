import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/main.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customExpansionTile.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardController extends GetxController with StateMixin {
  ApiServices api = ApiServices();

  RxString selectedFilter = 'All Meetings'.obs;

  List<AllMeetings> allMeetingslist = [];

  int indexOfTab = 0;

  // RxList<AllMeetings> listToShowBackup = <AllMeetings>[].obs;

  // List<AllMeetings> doneMeetings = [];

  // List<AllMeetings> upcomingMeetings = [];

  List<AllMeetings> listToShow = <AllMeetings>[];

  RxList<AllUserModel> allUserList = <AllUserModel>[].obs;

  RxList<AllUserModel> listBro = <AllUserModel>[].obs;

  RxList<FindNotesModel> notesList = <FindNotesModel>[].obs;

  // RxList<AllMeetings> internalMeetingList = <AllMeetings>[].obs;

  // RxList<AllMeetings> externalMeetingList = <AllMeetings>[].obs;

  RxBool loading = false.obs;

  RxBool loading1 = false.obs;
  var helo = 0.obs;

  @override
  void onInit() async {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();
    print('fff');
    await token();
    helo.value = 2;
    await getsss();

    // getNotes('1', null);
  }

  token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    var token = await prefs.getString('token');
    var data = await ApiServices().updateFCMToken(id, token);
    print(token);
    if (token != null) {
      sendPushMessage(token);
    }
  }

  frfr(val) {
    print('$val dcdcd');
    selectedFilter.value = val;
    print(selectedFilter.value);
    update();
  }

  Rx<UserModel> user = UserModel().obs;

  getsss() async {
    change(null, status: RxStatus.loading());
    // RxStatus.loading();
    // print('dddd');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    print(id);

    ///todo

    var res = await api.getAllMeetings(id!);

    if (res != false) {
      // var data = await json.decode(res);

      allMeetingslist =
          await List<AllMeetings>.from(res.map((x) => AllMeetings.fromJson(x)));

      RxList<AllMeetings> userID = <AllMeetings>[].obs;
      showUpcomingList();
    }

    var email = await prefs.getString('email');
    var password = await prefs.getString('password');

    var login = await api.login(email: email!, password: password!);

    // var data = json.decode(login);

    user.value = UserModel.fromJson(login);

    change(null, status: RxStatus.success());

//     allMeetingslist.forEach((e) {

// userID.add(item);
//       e.siecParticipants!.where((element) => element.id == userID);
//       e.meetingCoordinator!.where((element) => element.id == userID);
//     });

    // var res2 = await api.getDropdown(Endpoints.allUser);

    // var data2 = await json.decode(res2);

    // allUserList.value = await List<AllUserModel>.from(
    //     data2.map((x) => AllUserModel.fromJson(x)));

    // listBro.value =
    //     List<AllUserModel>.from(allUserList.map((element) => element)).toList();
    // loading1.value = true;

    // list = await data;

    // allMeetingslist.where((element) {
    //   print(element);
    //   if (element.meetingEnded == true) {
    //     print(element);
    //     doneMeetings.add(element);
    //   }

    //   return true;
    // });
    // print(doneMeetings.length);

    // for (var i = 0; i < allMeetingslist.length; i++) {
    //   if (allMeetingslist[i].meetingEnded == true) {
    //     doneMeetings.add(allMeetingslist[i]);
    //     print(doneMeetings);
    //   } else {
    //     upcomingMeetings.add(allMeetingslist[i]);
    //   }
    // }
    // loading.value = false;

    // listToShow = upcomingMeetings;

    // update();
  }

  Rx<AllMeetings> selectedMeetingdata = AllMeetings().obs;

  List<Map<String, List<Widget>>> dataBaazi = [];
  List<FindNotesModel> meetingNotesList = [];
  List<FindNotesModel> observationNotesList = [];
  List<FindNotesModel> proposeChangesNotesList = [];
  List<FindNotesModel> processNotesList = [];
  List<FindNotesModel> traningNotesList = [];
  List<FindNotesModel> requirementsNotesList = [];
  List<FindNotesModel> universityNotesList = [];
  List<FindNotesModel> offlineMarketingNotesList = [];

  List<Widget> documentlist = [];

  getNotes(String id, int? index) async {
    if (index != null) {
      selectedMeetingdata.value = listToShow[index];
    }
    var res = await api.findNotes(id);

    print('res');

    print(res.toString());

    // List<FindNotesModel> data = List<FindNotesModel>.from(
    //     json.decode(res).map((x) => FindNotesModel.fromJson(x)));

    var data =
        List<FindNotesModel>.from(res.map((x) => FindNotesModel.fromJson(x)));
    notesList.value = await data;

/////
    ///

    List notesType = [];
    List notesTypeString = [];

    for (var i = 0; i < notesList.length; i++) {
      notesType.add(notesList[i].noteType);
    }

    notesType = notesType.toSet().toList();

    for (var i = 0; i < notesType.length; i++) {
      var res = getNoteTypefromId(notesType[i]);

      // var data1 = res.toString().split(' ')[0];
      // var data2 = res.toString().split(' ')[1] == null
      //     ? ''
      //     : res.toString().split(' ')[1];
      // print(data1 + data2);

      // print(temp);

      notesTypeString.add(res);
    }

    List<Map<String, List<FindNotesModel>>> list = [];
    for (var i = 0; i < notesType.length; i++) {
      list.add({notesTypeString[i]: []});
    }

    for (var i = 0; i < notesList.length; i++) {
      for (var j = 0; j < notesTypeString.length; j++) {
        if (list[j].entries.first.key ==
            getNoteTypefromId(notesList[i].noteType!)) {
          list[j].entries.first.value.add(notesList[i]);
        }
      }

      // if(  notesList[i].noteType )
      // list.add({[]: })
    }

    List<Widget> beta = [];
    for (var i = 0; i < list.length; i++) {
      beta.add(CustomExpansionPlanList(
        titel: list[i].keys.first,
        dataList: list[i].values.first,
      ));
      // documentlist.addAll(list[i].entries.first.value);
    }
    documentlist = [];
    documentlist = beta;
    print(documentlist.length);

    update();

    // dataBaazi = list;

    ///todo
    // await notesList.value.where((e) {
    //   if (e.noteType == 1) {
    //     meetingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 2) {
    //     observationNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 3) {
    //     proposeChangesNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 4) {
    //     processNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 5) {
    //     traningNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 6) {
    //     requirementsNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 7) {
    //     universityNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 8) {
    //     offlineMarketingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // proposeChangesNotesList =
    //     await notesList.value.where((e) => e.noteType == 3).toList();
    // processNotesList =
    //     await notesList.value.where((e) => e.noteType == 4).toList();

    // traningNotesList =
    //     await notesList.value.where((e) => e.noteType == 5).toList();
    // requirementsNotesList =
    //     await notesList.value.where((e) => e.noteType == 6).toList();

    // universityNotesList =
    //     await notesList.value.where((e) => e.noteType == 7).toList();

    // offlineMarketingNotesList =
    //     await notesList.value.where((e) => e.noteType == 8).toList();
  }

  RxBool upcomingbuttonEnable = true.obs;

  // internalMeeting() {
  //   internalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'Internal Meeting')
  //       .toList();
  // }

  // enternalMeeting() {
  //   externalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'External Meeting')
  //       .toList();
  // }

  changeInFilter() async {
    if (indexOfTab == 0) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == false,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'university' && p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 's' &&
                p0.meetingEnded == false &&
                p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == false)
            .toList();
      }
    } else if (indexOfTab == 1) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == true,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'university' && p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 's' &&
                p0.meetingEnded == true &&
                p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == true)
            .toList();
      }
    }

    update();
  }

  showUpcomingList() async {
    // print('ddd');

    changeInFilter();
  }

  // upcomingMeetings;
  //   await Future.delayed(Duration(seconds: 2));

  //   // change(listToShow, status: RxStatus.success());
  //   loading.value = false;
  //   // update();
  // }

  showDoneList() async {
    changeInFilter();
    loading.value = false;
    print('ddddd');

    // listToShow = doneMeetings;

    // if (selectedFilter.value == "All Meetings") {
    //   listToShow = await allMeetingslist
    //       .where(
    //         (ele) => ele.meetingEnded == false,
    //       )
    //       .toList();
    // } else if (selectedFilter.value == "University Meeting") {
    //   listToShow = await internalMeetingList
    //       .where(
    //           (p0) => p0.meetingWith == 'university' && p0.meetingEnded == true)
    //       .toList();
    // } else if (selectedFilter.value == "Vendor Meeting") {
    //   listToShow = await internalMeetingList
    //       .where((p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
    //       .toList();
    // }

    // // upcomingMeetings;
    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;

    // showSpecificMeeting(value) async {
    //   listToShowBackup = listToShow;

    //   if (selectedFilter.value == 'Vendor Meeting') {
    //     listToShow = await listToShowBackup
    //         .where(
    //           (ele) => ele.meetingEnded == true && ele.meetingWith == 'vendor',
    //         )
    //         .toList();

    //     update();
    //   }
    // }

    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;
    // // change(loading, status: RxStatus.success());
    // update();
  }

  bool hitResheduleAPI = false;

  resheduleMeeting(data) async {
//     {
//     "meetingId": 3,
//     "reasonOfReshedule": "test",
//     "rescheduleDate": "12/10/2004",
//     "rescheduleTime": "20:20",
//     "rescheduleDuration": "20 hours 20 minutes",
//     "meetingType": "zoom",
//     "modeOfMeeting": "0" ,
//     "meetingLink": "test",
//     "updatedBY": 44

// }

    var res = await api.resheduleMeeting(data);
    Get.back();
    //todo
    Get.defaultDialog();
    getsss();
  }
}
