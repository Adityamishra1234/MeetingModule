import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allBranchModel.dart';
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
    getBranchData();
    getAllCountries();
    // inItGetRepresentative();

    getRepresentativeDropDownData();

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

  RxList<String> groupNamesAudienceType = [
    'IT Team',
    'Australia Applications',
    'SSU Team',
    'Canada Advisors',
    'Europe Team'
  ].obs;

  // RxList branchList = [
  //   'IT ssss',
  //   'Australia Applications',
  //   'SSU Team',
  //   'Canada Advisors',
  //   'Europe Team'
  // ].obs;

  RxString selectedBranch = ''.obs;

  RxString selectedTargetAudience = ''.obs;

  RxString groupNames = ''.obs;

  RxList<AllUserModel> selectedUsersList = <AllUserModel>[].obs;

  RxList<dynamic> selectedCoordinatorList = <dynamic>[].obs;

  RxList<SelectAudienceType> targetAudienceList = <SelectAudienceType>[].obs;

  RxList<AllUserModel> preFilledUsers = <AllUserModel>[].obs;

  RxList<String> branchList = <String>[].obs;

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
//
//
//

  ///
//// ADD Representative
  ///
  ///
  RxString addRepresentaitveType = 'University'.obs;
  Rx<AllUserModel> selectedCountry = AllUserModel().obs;
  Rx<AllUserModel> selectedUniversityName = AllUserModel().obs;

  RxList<AllUserModel> allCountriesList = <AllUserModel>[].obs;

  RxList<AllUserModel> allUniversityList = <AllUserModel>[
    AllUserModel.fromJson({'name': "true", "id": 5})
  ].obs;

  Rx<TextEditingController> nameOfTheVendor = TextEditingController().obs;
  Rx<TextEditingController> nameOfTheBank = TextEditingController().obs;
  // RxString nameOfTheBank = ''.obs;
  RxString meetingWith = 'University Meetings'.obs;

  Rx<TextEditingController> nameOfThePerson = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> designation = TextEditingController().obs;
  Rx<TextEditingController> RePphoneNumber = TextEditingController().obs;

  Rx<RepresentativeModel> repModel = RepresentativeModel().obs;
  addANewRepresentative() async {
    print(repModel.value.toJson());

    repModel.value.representativeType = addRepresentaitveType.value;
    repModel.value.personName = nameOfThePerson.value.text;
    repModel.value.designation = designation.value.text;
    repModel.value.email = email.value.text;
    repModel.value.phone = int.parse(RePphoneNumber.value.text);
    repModel.value.country = selectedCountry.value.id;
    repModel.value.university = selectedUniversityName.value.id;
    repModel.value.vendorName = nameOfTheVendor.value.text;
    repModel.value.bankName = nameOfTheBank.value.text;
    repModel.value.isActive = true;

    ///created by dO  later
    repModel.value.createdBy = 136;
    repModel.value.updatedBy = 136;

    await api.addRepresentative(repModel.value);
  }

  getAllCountries() async {
    var res = await api.getAllCountries();
    allCountriesList.value =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    // print(allCountriesList.toString());
  }

  getUniversities(int countryId) async {
    var res = await api.getAllUniversity(countryId);

    allUniversityList.value =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    // print(allUniversityList.toString());
  }

  ///AddParticipants

  inItGetRepresentative() async {
    print(meetingWith.value.substring(0, meetingWith.value.length - 8));
    var data = meetingWith.value.substring(0, meetingWith.value.length - 8);

    var res = await api.findRepresentative(data);

    var list = List<RepresentativeModel>.from(
        res.map((e) => RepresentativeModel.fromJson(e))).toList();
  }

  getRepresentative() async {
    // var meeting =
    // var res = await api.findRepresentative(meetingWith.value.split('').toString() );
  }

  RxList<AllUserModel> listOfParticipantData = <AllUserModel>[].obs;
  getRepresentativeDropDownData() async {
    print(meetingWith.value.substring(0, meetingWith.value.length - 8));
    var data = meetingWith.value.split(' ')[0];
    // substring(0, meetingWith.value.length - 9);

    print(data);

    var res = await api.findRepresentativeForDropDown(data);

    var res2 = json.decode(res);
    listOfParticipantData.value =
        List<AllUserModel>.from(res2.map((e) => AllUserModel.fromJson(e)))
            .toList();

    // print(listOfParticipantData.value[0].toJson());
    update();
  }

  //// participants
  ///
  ///
  Rx<AllUserModel> participantID = AllUserModel().obs;
  Rx<RepresentativeModel> participantData = RepresentativeModel().obs;

  fetchParticipantData() async {
    print(participantID.value.id);
    var res = await api.getRepresentativeAllData(participantID.value.id!);

    var data = json.decode(res);

    participantData.value = RepresentativeModel.fromJson(data);

    update();

    print(participantData.value.toJson());
  }
//
////
/////
////
////
  ///
  ///
  ///

  RxList<AllBranchModel> allBranchList = <AllBranchModel>[].obs;
  createNewMeeting() async {
    meetingModel.value.meetingAgenda = agendaPurposeOfMeeting.value;

    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;

    meetingModel.value.dateOfMeeting = dateController.value;

    meetingModel.value.timeOfTheMeeting = timeController.value;

    meetingModel.value.durationOfMeeting = proposedDuration.value.text;

    meetingModel.value.meetingMode = MeetingType.value;

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    // print(modeOfMeeting.value);

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
        selectedCoordinatorList
            .map((e) => SiecParticipants.fromJson(e.toJson())));

    // var res = await api.createMeeting(meetingModel.value);
    // print(res);

    // meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;
    api.addMeeting(meetingModel.value);
  }

  getGroupData() async {
    var res = await api.selectedAudienceType();
    targetAudienceList.value = List<SelectAudienceType>.from(
        res.map((e) => SelectAudienceType.fromJson(e)));
    // print(targetAudienceList);
  }

  getBranchData() async {
    // print('fvffg');
    var res = await api.allBranch();

    var data =
        List<AllBranchModel>.from(res.map((e) => AllBranchModel.fromJson(e)));
    print(data.toString());

    branchList.value = data.map((e) => e.branchName!).toList();

    allBranchList.value = data;

    update();
  }

  branchSelected(val) async {
    print(val);
    selectedBranch.value = val;
    // var branchCode = allBranchList.value.map(
    //     (e) => e.branchName!.toLowerCase() == val.toString().toLowerCase(),
    //     print(e));
    // print(branchCode);
    int code = 0;
    var bb = allBranchList.forEach((e) {
      if (e.branchName!.toLowerCase() == val.toString().toLowerCase()) {
        code = e.id!;
      }
    });

    var res = await api.getSpecificBranchUsers(code);

    var data =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));
    preFilledUsers.value = await data;
    selectedUsersList.value = preFilledUsers.value;
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

    selectedUsersList.value = preFilledUsers.value;
    print(preFilledUsers.value.toString());

    update();

    // change(preFilledUsers, status: RxStatus.success());

    // print(Get.find<DashBoardController>().listBro);

    // print(preFilledUsers.value.toString());
  }
}
