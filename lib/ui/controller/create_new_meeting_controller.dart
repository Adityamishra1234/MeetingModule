import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/selectedAudienceTypeModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsersCore.dart';

class CreateNewMeetingController extends GetxController with StateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getGroupData();
    change(null, status: RxStatus.success());
  }

  RxString agendaPurposeOfMeeting = 'All Meetings'.obs;

//
//
  Rx<TextEditingController> meetingNameController = TextEditingController().obs;
//
//
  RxString dateController =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
          .obs;
  //
  //
  RxString timeController =
      '${DateTime.now().hour}:${DateTime.now().minute}'.obs;

//
  Rx<TextEditingController> proposedDuration = TextEditingController().obs;

  ///
  ///
  ///
  RxBool MeetingType = true.obs;

  RxBool meetingLocation = true.obs;

  RxString selectMeetingBranch = ''.obs;

  RxString modeOfMeeting = ''.obs;

  ///
  ///
  ///

  Rx<TextEditingController> specifyMeetingLocation =
      TextEditingController().obs;
  //

  Rx<TextEditingController> meetingLink = TextEditingController().obs;

  //
  List<String> selectTargetAudienceType = <String>[
    'Select Target Audience Type',
    'Group Wise',
    'Branch Based',
    'User Based',
    'All User'
  ];

  List<String> groupNamesAudienceType = [
    'IT Team',
    'Australia Applications',
    'SSU Team',
    'Canada Advisors',
    'Europe Team'
  ];

  RxList branchList = [
    'IT ssss',
    'Australia Applications',
    'SSU Team',
    'Canada Advisors',
    'Europe Team'
  ].obs;

  RxString selectedBranch = ''.obs;

  RxString selectedTargetAudience = ''.obs;

  RxString groupNames = ''.obs;

  RxList<AllUserModel> selectedUsersList = <AllUserModel>[].obs;

  RxList<dynamic> selectedCoordinatorList = <dynamic>[].obs;

  RxList<SelectAudienceType> targetAudienceList = <SelectAudienceType>[].obs;

  RxList<AllUserModel> preFilledUsers = <AllUserModel>[].obs;

  // Rx<TextEditingController> dateController = TextEditingController().obs;

  RxBool externalMeeting = false.obs;
  Rx<AllMeetings> meetingModel = AllMeetings().obs;
  ApiServices api = ApiServices();

  // RxString proposedDuration = ''.obs;

  List<String> list = <String>[
    'All Meetings',
    'University Meeting',
    'Bank Meeting',
    'Vendor Meeting',
    'Internal Meeting'
  ];

  ///External Meeting
  ///
  List<String> meetingWithList = <String>[
    'University Meetings',
    'Vendor Meeting',
    'Bank Meeting',
  ];

  createNewMeeting() async {
    meetingModel.value.meetingAgenda = agendaPurposeOfMeeting.value;

    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;

    meetingModel.value.dateOfMeeting = dateController.value;

    meetingModel.value.timeOfTheMeeting = timeController.value;

    meetingModel.value.durationOfMeeting = proposedDuration.value.text;

    meetingModel.value.meetingMode = MeetingType.value;

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    print(modeOfMeeting.value);

    meetingModel.value.meetingLink = meetingLink.value.text;

    ///offline
    meetingModel.value.locationOfTheMeeting = meetingLocation.value.toString();

    // meetingModel.value.siecBranch =
    // meetingModel.value.meetingType = MeetingType.value;

    List cc = [
      {"name": "Shreya IT", "id": 115},
      {"name": "Kashish IT", "id": 142}
    ];

    // for (var i = 0; i < 5; i++) {}

    // print(selectedUsersList);

    meetingModel.value.siecParticipants = List<SiecParticipants>.from(
        selectedUsersList.map((e) => SiecParticipants.fromJson(e.toJson())));

    meetingModel.value.meetingCoordinator = List<SiecParticipants>.from(
        selectedUsersList.map((e) => SiecParticipants.fromJson(e.toJson())));

    // var res = await api.createMeeting(meetingModel.value);
    // print(res);

    // meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;
    api.addMeeting(meetingModel.value);
  }

  getGroupData() async {
    var res = await api.selectedAudienceType();
    targetAudienceList.value = List<SelectAudienceType>.from(
        res.map((e) => SelectAudienceType.fromJson(e)));
    print(targetAudienceList);
  }

  showList(query) async {
    // print(query.toString().toLowerCase());
    // print(targetAudienceList.value
    //     .map((e) => e.teamName.toString().toLowerCase()));
    List<SelectAudienceType> data = await targetAudienceList.value
        .where((element) =>
            element.teamName!.toLowerCase() == query.toString().toLowerCase())
        .toList();

    preFilledUsers.value = await data[0].teamMembers!;
    // await List<AllUserModel>.from(data.map((e) => e.teamMembers!));

    update();

    change(preFilledUsers, status: RxStatus.success());

    // print(Get.find<DashBoardController>().listBro);

    // print(preFilledUsers.value.toString());
  }
}
