import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/findParticipantByIdModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMoreNotesController extends GetxController with StateMixin {
  RxList<int> notesVisibleToList = <int>[5, 80, 77].obs;

  bool addNotes = true;
  // Model
  ApiServices api = ApiServices();
  RxList<FindNotesModel> model = <FindNotesModel>[].obs;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

// Text fields
  Rx<TextEditingController> noteText = TextEditingController().obs;

  //Selcted dropdown fields
  RxString noteTypeSelected = "".obs;
  RxInt noteTypeSelectedID = 0.obs;
  RxList<AllUserModel> accessibileUserSelected = RxList<AllUserModel>();

  //For meeting details page
  Rx<TextEditingController> noteText_meetingdetails =
      TextEditingController().obs;
  RxList<AllUserModel> accessibileUserSelected_meetingDetail =
      RxList<AllUserModel>();

  @override
  void onInit() async {
    super.onInit();

    // await meetingId();
    // await checkUserIsCordinator();
    // await getMeetingParticipantsList();

    change(null, status: RxStatus.success());
  }

  addNote(int meetingID) async {
    // print(noteText.value.text);
    // model.value.note = await noteText.value.text;

    // model.value.noteType = await noteType.value;
    // model.value.visibleTo = await notesVisibleToList.toString();

    // // print(model.value);

    // // var res = await api.addNotes(meetingID, noteType.value, noteText.value.text,
    // //     "ddd", notesVisibleToList.value);

    // var res = await api.addNotes(model.value);
  }

  saveAndNext(int metingID) async {
    print(metingID);
    change(null, status: RxStatus.loading());
    List<AllUserModel> visibleTo = [];
    for (var element in accessibileUserSelected) {
      visibleTo = visibleTo;
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: noteTypeSelectedID.value,
        visibleTo: visibleTo,
        note: noteText.value.text,
        isActive: true,
        isAdded: true,
        createdBy: 101,
        updatedBy: 101);

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(res);
      model;
      model.refresh();
      noteTypeSelected = "".obs;
      noteTypeSelectedID = 0.obs;
      accessibileUserSelected = RxList<AllUserModel>();
      noteText.value.text = "";
      change(null, status: RxStatus.success());
    }
  }

  saveNotes(int metingID) async {
    change(null, status: RxStatus.loading());
    List<AllUserModel> visibleTo = [];
    for (var element in accessibileUserSelected_meetingDetail) {
      visibleTo = visibleTo;
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: 1,
        visibleTo: visibleTo,
        note: noteText_meetingdetails.value.text,
        isActive: true,
        isAdded: true,
        createdBy: 101,
        updatedBy: 101);

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(res);
      model;
      model.refresh();
      noteText_meetingdetails.value.text = "";
      accessibileUserSelected_meetingDetail.value = [];
      accessibileUserSelected_meetingDetail.refresh();
      change(null, status: RxStatus.success());
    }
  }

  bool meetingStartedValue = false;
  bool meetingEndedValue = false;
  int id = 0;

  meetingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = await prefs.getInt('id')!;
  }

  meetingStarted(int meetingId, bool val) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var id = await prefs.getInt('id');
    var controllerDashboard = Get.find<DashBoardController>();

    AllMeetings meetingData = controllerDashboard.selectedMeetingdata.value;
    var res = await api.meetingStartedOrEnded(meetingId, id!, 0, val);
    meetingData.meetingStarted = val;

    // await Get.find<DashBoardController>().getsss();
    update();
  }

  meetingEnded(int meetingId, bool val) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var id = await prefs.getInt('id');
    var controllerDashboard = Get.find<DashBoardController>();

    AllMeetings meetingData = controllerDashboard.selectedMeetingdata.value;
    var res = await api.meetingStartedOrEnded(meetingId, id!, 1, val);
    meetingData.meetingEnded = val;
    await controllerDashboard.changeInFilter();
    // controllerDashboard.indexOfTab.value =
    //     controllerDashboard.indexOfTab.value == 0 ? 1 : 0;
    controllerDashboard.update();
    update();
  }

  bool showTheStartEndOptions = false;

  checkUserIsCordinator() {
    print(id);
    var data = Get.find<DashBoardController>()
        .selectedMeetingdata
        .value
        .meetingCoordinator;

    var started =
        Get.find<DashBoardController>().selectedMeetingdata.value.createdBy;

    data!.forEach((element) {
      if (element.id == id || started == id) {
        showTheStartEndOptions = true;
      } else {
        print('${element.id}dddddddd');
        showTheStartEndOptions = false;
      }
    });
  }

  List<FindParticipantByMeetingIdModel> participantList = [];

  List<Widget> participantDataList = [];

  getMeetingParticipantsList() async {
    var controllerDashboard = Get.find<DashBoardController>();

    if (controllerDashboard.selectedMeetingdata.value.meetingType ==
        'External Meeting') {
      var res = await api.findParticipantByMeetingId(
          controllerDashboard.selectedMeetingdata.value.id!);

      participantList = await List<FindParticipantByMeetingIdModel>.from(
          res.map((e) => FindParticipantByMeetingIdModel.fromJson(e)));

      List<RepresentativeModel> dataList = [];
      for (var i = 0; i < participantList.length; i++) {
        var res = await api
            .getRepresentativeAllData(participantList[i].participantId!);

        var data = json.decode(res);

        var deta = RepresentativeModel.fromJson(data);

        dataList.add(deta);
      }

      for (var i = 0; i < dataList.length; i++) {
        participantDataList.add(Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: ThemeConstants.lightVioletColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: ThemeConstants.blackcolor,
                  size: 15,
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${dataList[i].personName}'),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text('Designation: ${dataList[i].designation}'),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text('Email: ${dataList[i].email}'),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text('Phone: ${dataList[i].phone}'),
                  ]),
            ],
          ),
        ));
      }
      update();

      // participantsList.forEach((element) {

      // });
      print(participantList);
    }
  }
}
