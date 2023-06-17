import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allBranchModel.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/participantsModel.dart';
import 'package:meeting_module2/models/selectedAudienceTypeModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsersCore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewMeetingController2 extends GetxController with StateMixin {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getGroupData();
    await getBranchData();
    await getAllCountries();
    await getUniversities(13);
    await userID();
    // inItGetRepresentative();
    await getRepresentativesByUniversity();

    await fetchParticipantData();
    // await getRepresentativeDropDownData();

    update();

    change(null, status: RxStatus.success());
  }

  var idForAllUse = 0;

  userID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idForAllUse = await prefs.getInt('id')!;
  }
//////Common in Both

  RxString agendaPurposeOfMeeting = 'All Meetings'.obs;

  Rx<TextEditingController> meetingNameController = TextEditingController().obs;

  RxString dateController =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
          .obs;

  RxString timeController =
      '${DateTime.now().hour}:${DateTime.now().minute}'.obs;

  RxString proposedDurationController = '0 hours 0 minutes'.obs;

  Rx<TextEditingController> proposedDuration = TextEditingController().obs;

  RxBool MeetingType = true.obs; //true online

  String meetingLocation = ''; //

  Rx<AllUserModel> selectMeetingBranch = AllUserModel().obs;

  RxString modeOfMeeting = 'Zoom'.obs;
  Rx<TextEditingController> specifyMeetingLocation =
      TextEditingController().obs;

  Rx<TextEditingController> meetingLink = TextEditingController().obs;

  // Drop down list
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

  List<String> list = <String>[
    'All Meetings',
    'University Meeting',
    'Bank Meeting',
    'Vendor Meeting',
    'Internal Meeting'
  ];

  List<String> meetingWithList = <String>[
    'University Meetings',
    'Vendor Meeting',
    'Bank Meeting',
  ];
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

  List<AllUserModel> selectedUsersList = <AllUserModel>[];

  RxList<dynamic> selectedCoordinatorList = <dynamic>[].obs;

  RxList<SelectAudienceType> targetAudienceList = <SelectAudienceType>[].obs;

  List<AllUserModel> preFilledUsers = <AllUserModel>[];

  List<AllUserModel> branchList = <AllUserModel>[];

  // Rx<TextEditingController> dateController = TextEditingController().obs;

  bool externalMeeting = false;
  Rx<AllMeetings> meetingModel = AllMeetings().obs;
  ApiServices api = ApiServices();

  // RxString proposedDuration = ''.obs;

  ///External Meeting
  ///

//
//
//

  ///
//// ADD Representative
  ///
  ///
  RxString addRepresentaitveType = 'University'.obs;
  AllUserModel selectedCountry = AllUserModel();
  Rx<AllUserModel> selectedUniversityName = AllUserModel().obs;

  List<AllUserModel> allCountriesList = <AllUserModel>[];

  List<AllUserModel> allUniversityList = <AllUserModel>[
    AllUserModel.fromJson({'name': "true", "id": 5})
  ];

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
    repModel.value.representativeType = addRepresentaitveType.value;
    repModel.value.personName = nameOfThePerson.value.text;
    repModel.value.designation = designation.value.text;
    repModel.value.email = email.value.text;
    repModel.value.phone = int.parse(RePphoneNumber.value.text);

    if (addRepresentaitveType.value == 'Vendor' ||
        addRepresentaitveType.value == 'Bank') {
      repModel.value.country = null;
      repModel.value.university = null;
    } else {
      repModel.value.country = selectedCountry.id ?? 13;
      repModel.value.university = selectedUniversityName.value.id ?? 3263;
    }

    print(selectedUniversityName.value.id);
    repModel.value.vendorName = nameOfTheVendor.value.text;
    repModel.value.bankName = nameOfTheBank.value.text;
    repModel.value.isActive = true;

    ///created by dO  later
    repModel.value.createdBy = idForAllUse;
    repModel.value.updatedBy = idForAllUse;
    print(repModel.value.toJson());
    var res = await api.addRepresentative(repModel.value);

    await fetchParticipantData();
    return res;
  }

  getAllCountries() async {
    var res = await api.getAllCountries();
    allCountriesList =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));
    update();
    // print(allCountriesList.toString());
  }

  getUniversities(int countryId) async {
    var res = await api.getAllUniversity(countryId);

    allUniversityList =
        await List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    update();
    print(allUniversityList.toString());
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

  List<AllUserModel> listOfParticipantData = <AllUserModel>[];
  getRepresentativeDropDownData() async {
    print(meetingWith.value.substring(0, meetingWith.value.length - 8));
    var data = meetingWith.value.split(' ')[0];
    // substring(0, meetingWith.value.length - 9);

    print(data);

    var res = await api.findRepresentativeForDropDown(data);

    listOfParticipantData =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)))
            .toList();

    update();

    // print(listOfParticipantData.value[0].toJson());
  }

  //// participants
  ///
  ///
  Rx<AllUserModel> participantID = AllUserModel().obs;
  Rx<RepresentativeModel> participantData = RepresentativeModel().obs;

  fetchParticipantData() async {
    print(participantID.value.id);
    var res = await api.getRepresentativeAllData(
        participantID.value.id == null ? 2 : participantID.value.id!);

    participantData.value = RepresentativeModel.fromJson(res);

    update();

    print(participantData.value.toJson());
  }

  AllUserModel selectedUniversity = AllUserModel();
  Rx<AllUserModel> selectedCountryForFetchRep = AllUserModel().obs;

  getRepresentativesByUniversityINIT() async {
    // print(selectedCountry.value.id!);
    // print(selectedCountry.value.id!);

    var res = await api.getRepresentativeByUniversity(
        type: 'University',
        collegecode: selectedUniversity.id!,
        countrycode: selectedCountry.id!);

    var res2 = json.decode(res);
    listOfParticipantData =
        List<AllUserModel>.from(res2.map((e) => AllUserModel.fromJson(e)))
            .toList();

    print(res);
  }

  getRepresentativesByUniversity() async {
    // print(selectedCountry.value.id!);
    // print(selectedCountry.value.id!);

    var res = await api.getRepresentativeByUniversity(
        type: 'University',
        collegecode:
            selectedUniversity.id == null ? 3263 : selectedUniversity.id!,
        countrycode: selectedCountry.id == null ? 13 : selectedCountry.id!);

    if (res == null) {
      var res4 = [
        {'name': "No Representative! Please Add", "id": 0}
      ];

      listOfParticipantData = await List<AllUserModel>.from(
          res4.map((e) => AllUserModel.fromJson(e))).toList();
    } else {
      // var res2 = await json.decode(res);

      listOfParticipantData = await List<AllUserModel>.from(
          res.map((e) => AllUserModel.fromJson(e))).toList();
      update();
      print(res);
    }
  }

  RxList<RepresentativeModel> listOfParticipants = <RepresentativeModel>[].obs;

  List<Widget> allParticipants(CreateNewMeetingController2 controller) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipants.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipants[i].personName}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].designation}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].email}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].phone}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    controller.listOfParticipants.removeAt(i);
                    update();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ThemeConstants.lightRed),
                    child: Icon(
                      Icons.delete,
                      color: ThemeConstants.red,
                      size: 25,
                    ),
                  )),
            )
          ],
        ),
      ));
    }

    return data;
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
    meetingModel.value.meetingWith = '';

    meetingModel.value.meetingType = 'Internal Meeting';

    meetingModel.value.meetingAgenda = agendaPurposeOfMeeting.value;

    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;

    meetingModel.value.dateOfMeeting = dateController.value;

    meetingModel.value.timeOfTheMeeting = timeController.value;

    meetingModel.value.durationOfMeeting = proposedDurationController.value;

    meetingModel.value.meetingMode = MeetingType.value == true ? '1' : '0';

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    // print(modeOfMeeting.value);

    meetingModel.value.meetingLink = meetingLink.value.text;

    ///offline
    ///
    ///
    meetingModel.value.locationOfTheMeeting = meetingLocation;

    meetingModel.value.specificLocationOfTheMeeting =
        specifyMeetingLocation.value.text;

    meetingModel.value.siecBranch =
        selectMeetingBranch.value.id == null ? 0 : selectMeetingBranch.value.id;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    meetingModel.value.createdBy = id;

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
    await api.addMeeting(meetingModel.value);

    change(null, status: RxStatus.loading());
    Get.find<DashBoardController>().getMeetingData();
    Get.delete<CreateNewMeetingController2>();
    Get.put(CreateNewMeetingController2());
    change(null, status: RxStatus.success());
    Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.all(0),
        content: Container(
          width: 200,
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meeting Added Successfully',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.check_circle_rounded,
                  color: ThemeConstants.GreenColor,
                  size: 60,
                ),
              ]),
        ));
  }

  createExternalNewMeeting() async {
    meetingModel.value.meetingType = 'External Meeting';

    meetingModel.value.meetingWith = meetingWith.value == 'University Meetings'
        ? 'university'
        : meetingWith.value == 'Vendor Meeting'
            ? 'vendor'
            : meetingWith.value == 'Bank Meeting'
                ? 'bank'
                : 'univeristy';

    meetingModel.value.meetingAgenda = agendaPurposeOfMeeting.value;

    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;

    meetingModel.value.dateOfMeeting = dateController.value;

    meetingModel.value.timeOfTheMeeting = timeController.value;

    meetingModel.value.durationOfMeeting = proposedDurationController.value;

    meetingModel.value.meetingMode = MeetingType.value == true ? '1' : '0';

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    print('modeOfMeeting.value');

    meetingModel.value.meetingLink = meetingLink.value.text;

    ///offline
    meetingModel.value.siecBranch = selectMeetingBranch.value.id;

    meetingModel.value.specificLocationOfTheMeeting =
        specifyMeetingLocation.value.text;

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

    meetingModel.value.siecBranch =
        selectMeetingBranch.value.id == null ? 0 : selectMeetingBranch.value.id;
    // var res = await api.createMeeting(meetingModel.value);
    // print(res);

    // meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    meetingModel.value.createdBy = id;

    var res = await api.addMeeting(meetingModel.value);

    // var resDecoded = json.decode(res);

    print(res.toString());

    AllMeetings dd = AllMeetings.fromJson(res);

    List<ParticipantsModel> data = <ParticipantsModel>[].obs;

    var ko = List<ParticipantsModel>.from(
        listOfParticipants.map((element) => ParticipantsModel.fromJson({
              "id": null,
              "meeting_id": dd.id,
              "participant_id": element.id,
              "is_active": true,
              "created_by": 136,
              "updated_by": 136,
              "created_at": null,
              "updated_at": null
            })));

    var kd = await api.addParticipants(ko);
    print(kd.toString());

    change(null, status: RxStatus.loading());

    Get.delete<CreateNewMeetingController2>();
    Get.put(CreateNewMeetingController2());
    change(null, status: RxStatus.success());
    Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.all(0),
        content: Container(
          width: 200,
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Meeting Added Successfully',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.check_circle_rounded,
                  color: ThemeConstants.GreenColor,
                  size: 60,
                ),
              ]),
        ));
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
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));
    print(data.toString());

    branchList = data;

    // allBranchList.value = data;

    update();
  }

  branchSelected(AllUserModel val) async {
    print(val);
    // selectedBranch.value = val;
    // var branchCode = allBranchList.value.map(
    //     (e) => e.branchName!.toLowerCase() == val.toString().toLowerCase(),
    //     print(e));
    // print(branchCode);
    int code = val.id!;
    // var bb = allBranchList.forEach((e) {
    //   if (e.branchName!.toLowerCase() == val.toString().toLowerCase()) {
    //     code = e.id!;
    //   }
    // });

    var res = await api.getSpecificBranchUsers(code);

    var data =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));
    preFilledUsers = await data;
    selectedUsersList = preFilledUsers;
    update();
  }

  showList(query) async {
    // print(query.toString().toLowerCase());
    // print(targetAudienceList.value
    //     .map((e) => e.teamName.toString().toLowerCase()));
    List<SelectAudienceType> data = await targetAudienceList.value
        .where((element) =>
            element.teamName!.toLowerCase() == query.toString().toLowerCase())
        .toList();

    preFilledUsers = await data[0].teamMembers!;
    // await List<AllUserModel>.from(data.map((e) => e.teamMembers!));

    selectedUsersList = preFilledUsers;
    print(preFilledUsers.toString());

    update();

    // change(preFilledUsers, status: RxStatus.success());

    // print(Get.find<DashBoardController>().listBro);

    // print(preFilledUsers.value.toString());
  }
}
