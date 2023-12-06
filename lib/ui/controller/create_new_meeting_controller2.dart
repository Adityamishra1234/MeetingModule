import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allBranchModel.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/branchesWithImagesModel.dart';
import 'package:meeting_module2/models/participantsModel.dart';
import 'package:meeting_module2/models/selectedAudienceTypeModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewMeetingController2 extends GetxController with StateMixin {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getGroupData();
    await getBranchData();
    await getBranchData2();
    await getAllCountries();
    await getUniversities(13);
    await userID();
    await getAllAgenda();
    // inItGetRepresentative();
    await getRepresentativesByUniversity();

//TODO error handling
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

  RxString agendaPurposeOfMeeting = 'Accountability and Strategy Meetings'.obs;

  Rx<TextEditingController> meetingNameController = TextEditingController().obs;

  Rx<TextEditingController> addNewAgendaController =
      TextEditingController().obs;

  // RxString dateController =
  //     '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
  //         .obs;

  RxString dateController = ''.obs;

  RxString timeController = ''.obs;

  // RxString timeController =
  //     '${DateTime.now().hour}:${DateTime.now().minute}'.obs;

  RxString proposedDurationController = '0 hours 0 minutes'.obs;

  Rx<TextEditingController> proposedDuration = TextEditingController().obs;

  RxBool MeetingType = true.obs; //true online

  String? meetingLocation; //

  // Rx<AllUserModel> selectMeetingBranch = AllUserModel().obs;

  Rx<int> selectMeetingBranch = 0.obs;

  RxString modeOfMeeting = 'Zoom'.obs;
  Rx<TextEditingController> specifyMeetingLocation =
      TextEditingController().obs;

  Rx<TextEditingController> meetingLink = TextEditingController().obs;

  Rx<TextEditingController> registrationLink = TextEditingController().obs;

  bool selectedOption = false;
  // Drop down list
  List<String> selectTargetAudienceType = <String>[
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

  List<String> modeOfMeetingIcon = [
    'assets/images/zoom.png',
    'assets/images/Google_Meet.png',
    'assets/images/teams.png'
  ];

  List<String> modeOfMeetingList = ['Zoom', 'Meet', 'Teams'];

  RxString selectedBranch = ''.obs;

  RxString selectedTargetAudience = ''.obs;

  RxString groupNames = ''.obs;

  List<AllUserModel> selectedUsersList = <AllUserModel>[];

  RxList<dynamic> selectedCoordinatorList = <dynamic>[].obs;

  RxList<SelectAudienceType> targetAudienceList = <SelectAudienceType>[].obs;

  List<AllUserModel> preFilledUsers = <AllUserModel>[];

  List<AllUserModel> branchList = <AllUserModel>[];

  List<BranchWithImagesModel> branchListwithFlag = <BranchWithImagesModel>[];

  // Rx<TextEditingController> dateController = TextEditingController().obs;

  bool externalMeeting = false;
  Rx<AllMeetings> meetingModel = AllMeetings().obs;
  ApiServices api = ApiServices();

  bool existingRepresentative = false;

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

    return res;
  }

  getAllCountries() async {
    var res = await api.getAllCountries();
    allCountriesList =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    allCountriesList.insert(
        0, AllUserModel.fromJson({'name': "Kindly select", "id": 0}));

    print(allCountriesList);
    update();
    // print(allCountriesList.toString());
  }

  getUniversities(int countryId) async {
    var res = await api.getAllUniversity(countryId);

    allUniversityList =
        await List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    allUniversityList.insert(
        0, AllUserModel.fromJson({'name': "Kindly select", "id": 0}));

    print(allCountriesList);

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

  ///current
  List<AllUserModel> listOfParticipantData = <AllUserModel>[];
  getRepresentativeDropDownData() async {
    print(meetingWith.value.substring(0, meetingWith.value.length - 8));
    var data = meetingWith.value.split(' ')[0];
    // substring(0, meetingWith.value.length - 9);

    var res = await api.findRepresentativeForDropDown(data);

    listOfParticipantData =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)))
            .toList();

    if (data == 'Vendor') {
      await fetchReprenestativeDropDownDataFromVendorBankGroup(
          "0", '${listOfParticipantData[0].name}');
    } else if (data == 'Bank') {
      await fetchReprenestativeDropDownDataFromVendorBankGroup(
          "1", '${listOfParticipantData[0].name}');
    }
    update();

    // print(listOfParticipantData.value[0].toJson());
  }

  //// participants
  ///
  ///
  Rx<AllUserModel> participantID = AllUserModel().obs;
  RepresentativeModel participantData = RepresentativeModel();

  fetchParticipantData() async {
    print(participantID.value.id);
    var res = await api.getRepresentativeAllData(participantID.value.id == null
        ? listOfParticipantData[0].id!
        : participantID.value.id!);

    participantData = RepresentativeModel.fromJson(res);

    update();

    print(participantData.toJson());
  }

  makeParticipantDataClear() {
    participantData.bankName = null;
    participantData.country = null;
    participantData.createdAt = null;
    participantData.createdBy = null;
    participantData.designation = '';
    participantData.email = '';
    participantData.id = 0;
    participantData.isActive = null;
    participantData.personName = '';
    participantData.phone = null;
    update();
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

    if (res.length == 0) {
      var res4 = [
        {'name': "No Representative! Available Please Add", "id": 0}
      ];

      listOfParticipantData = await List<AllUserModel>.from(
          res4.map((e) => AllUserModel.fromJson(e))).toList();

      makeParticipantDataClear();

      update();
    } else {
      // var res2 = await json.decode(res);

      listOfParticipantData = await List<AllUserModel>.from(
          res.map((e) => AllUserModel.fromJson(e))).toList();

      listOfParticipantData.insert(
          0, AllUserModel.fromJson({'name': "Kindly select", "id": 0}));

      print(listOfParticipantData);
      update();
      print(res);
    }
  }

  List<RepresentativeModel> listOfParticipants = <RepresentativeModel>[];

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

  meetingTypeChanged(bool type) {}

  RxList<AllBranchModel> allBranchList = <AllBranchModel>[].obs;
  createNewMeeting(BuildContext context) async {
    meetingModel.value.meetingWith = '';

    meetingModel.value.meetingType = 'Internal Meeting';

    meetingModel.value.meetingAgenda = agendaPurposeOfMeeting.value;

    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;

    meetingModel.value.dateOfMeeting = dateController.value;

    meetingModel.value.timeOfTheMeeting = timeController.value;

    meetingModel.value.durationOfMeeting = proposedDurationController.value;

    meetingModel.value.meetingMode = MeetingType.value == true ? '1' : '2';

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    // print(modeOfMeeting.value);

    meetingModel.value.meetingLink = meetingLink.value.text;

    ///offline
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///

    // if (meetingLocation != null) {
    //   meetingModel.value.locationOfTheMeeting =
    //       meetingLocation == 'true' ? '1' : '2';
    // } else {
    //   meetingModel.value.locationOfTheMeeting = '';
    // }

    meetingModel.value.specificLocationOfTheMeeting =
        specifyMeetingLocation.value.text;

    meetingModel.value.siecBranch =
        selectMeetingBranch == null ? 0 : selectMeetingBranch.value;

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

    meetingModel.value.registrationLink = registrationLink.value.text;

    meetingModel.value.createdBy = id;
    meetingModel.value.updatedBy = id;

    print(meetingModel.value);

    // if (meetingModel.value.meetingMode == '2') {
    //   meetingModel.value.meetingModeType = '';
    //   meetingModel.value.meetingLink = '';
    //   meetingModel.value.registrationLink = '';
    //   meetingModel.value.siecBranch = 0;
    // } else {}

//todoImpo

    if (meetingModel.value.meetingMode == '1') {
      meetingModel.value.locationOfTheMeeting = '';
      meetingModel.value.specificLocationOfTheMeeting = '';
      meetingModel.value.siecBranch = 0;
    } else {
      meetingModel.value.locationOfTheMeeting =
          meetingLocation == 'true' ? '1' : '2';
      meetingModel.value.meetingModeType = '';
      meetingModel.value.meetingLink = '';
      meetingModel.value.registrationLink = '';
    }

    if (meetingModel.value.meetingMode == '2' &&
        meetingModel.value.locationOfTheMeeting == '1') {
      meetingModel.value.specificLocationOfTheMeeting = '';
    } else if (meetingModel.value.meetingMode == '2' &&
        meetingModel.value.locationOfTheMeeting == '2') {
      meetingModel.value.siecBranch = 0;
    }

    var res = await api.addMeeting(meetingModel.value);

    for (var i = 0; i < selectedUsersList.length; i++) {
      print(id);
      var data = {
        "id": 1,
        "meeting_id": res['id'],
        "meeting_notes_id": 0,
        "task_type": 'Meeting Notes Task',
        "deadline_date": "${meetingModel.value.dateOfMeeting}",
        "task_owner_id": selectedUsersList[i].id,
        "is_active": true,
        "closed_at": "0000-00-00 00:00:00",
        "closed_by": 0,
        "meeting_attented": false,
        "reason_of_not_attended": "",
        "created_by": id,
        "updated_by": id,
        "created_at": "2023-04-07T09:48:35.000Z",
        "updated_at": "2023-04-07T09:48:35.000Z",
        // "notes": ''
      };

      var assignToRes = await api.assignTo(data);
    }

    change(null, status: RxStatus.loading());
    getToast('Meeting updated');
    await generateTheNotifications();

    Get.delete<CreateNewMeetingController2>();
    Get.put(CreateNewMeetingController2());
    change(null, status: RxStatus.success());

    context.pop();

    // showPoPUp(
    //     'Meeting Added Successfully',
    //     Icon(
    //       Icons.check_circle_rounded,
    //       color: ThemeConstants.GreenColor,
    //       size: 60,
    //     ),
    //     context);
    // Get.defaultDialog(
    //     title: '',
    //     titlePadding: EdgeInsets.all(0),
    //     content: Container(
    //       width: 200,
    //       height: 200,
    //       child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(
    //               'Meeting Added Successfully',
    //               textAlign: TextAlign.center,
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),

    //           ]),
    //     ));
  }

  createExternalNewMeeting(BuildContext context) async {
    if (listOfParticipants.length < 1) {
      getToast('Add atleast one participant');

      // Get.defaultDialog(
      //     content: Container(
      //   child: Text('Please add atleast one participant'),
      // ));

      return true;
    }

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

    meetingModel.value.meetingMode = MeetingType.value == true ? '1' : '2';

    // if (meetingModel.value.meetingMode == '2') {
    //   meetingModel.value.meetingModeType = '';
    //   meetingModel.value.meetingLink = '';
    // }

    // if (meetingLocation != null) {
    //   meetingModel.value.locationOfTheMeeting =
    //       meetingLocation == 'true' ? '1' : '2';
    // } else {
    //   meetingModel.value.locationOfTheMeeting = '';
    // }

    /// online
    meetingModel.value.meetingModeType = modeOfMeeting.value;
    print('modeOfMeeting.value');

    meetingModel.value.meetingLink = meetingLink.value.text;

    ///offline
    meetingModel.value.siecBranch = selectMeetingBranch.value;

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
        selectMeetingBranch.value == null ? 0 : selectMeetingBranch.value;
    // var res = await api.createMeeting(meetingModel.value);
    // print(res);

    // meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    meetingModel.value.createdBy = id;

    meetingModel.value.registrationLink = registrationLink.value.text;

    meetingModel.value.createdBy = id;
    meetingModel.value.updatedBy = id;

    // if (meetingModel.value.meetingMode == '2') {
    //   meetingModel.value.meetingModeType = '';
    //   meetingModel.value.meetingLink = '';
    // } else {
    //   meetingModel.value.siecBranch = 0;
    // }

    if (meetingModel.value.meetingMode == '1') {
      meetingModel.value.locationOfTheMeeting = '';
      meetingModel.value.specificLocationOfTheMeeting = '';
      meetingModel.value.siecBranch = 0;
    } else {
      meetingModel.value.locationOfTheMeeting =
          meetingLocation == 'true' ? '1' : '2';
      meetingModel.value.meetingModeType = '';
      meetingModel.value.meetingLink = '';
      meetingModel.value.registrationLink = '';
    }

    if (meetingModel.value.meetingMode == '2' &&
        meetingModel.value.locationOfTheMeeting == '1') {
      meetingModel.value.specificLocationOfTheMeeting = '';
    } else if (meetingModel.value.meetingMode == '2' &&
        meetingModel.value.locationOfTheMeeting == '2') {
      meetingModel.value.siecBranch = 0;
    }

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
              "created_by": id,
              "updated_by": id,
              "created_at": null,
              "updated_at": null
            })));

    var kd = await api.addParticipants(ko);
    print(kd.toString());

    for (var i = 0; i < selectedUsersList.length; i++) {
      print(id);
      var data = {
        "id": 1,
        "meeting_id": res['id'],
        "meeting_notes_id": 0,
        "task_type": 'Training',
        "deadline_date": "${meetingModel.value.dateOfMeeting}",
        "task_owner_id": selectedUsersList[i].id,
        "is_active": true,
        "closed_at": "0000-00-00 00:00:00",
        "closed_by": 0,
        "meeting_attented": false,
        "reason_of_not_attended": "",
        "created_by": id,
        "updated_by": id,
        "created_at": "2023-04-07T09:48:35.000Z",
        "updated_at": "2023-04-07T09:48:35.000Z",
        // "notes": ''
      };

      var assignToRes = await api.assignTo(data);
    }

    change(null, status: RxStatus.loading());
    getToast('Meeting updated');

    await generateTheNotifications();

    Get.delete<CreateNewMeetingController2>();
    Get.put(CreateNewMeetingController2());
    change(null, status: RxStatus.success());

    getToast('Meeting updated');

    context.pop();
    // showPoPUp(
    //     'Meeting Added Successfully',
    //     Icon(
    //       Icons.check_circle_rounded,
    //       color: ThemeConstants.GreenColor,
    //       size: 60,
    //     ),
    //     context);
  }

  generateTheNotifications() async {
    List<int> idList = [];

    for (var i = 0; i < meetingModel.value.siecParticipants!.length; i++) {
      idList.add(meetingModel.value.siecParticipants![i].id!);
    }

    for (var i = 0; i < meetingModel.value.meetingCoordinator!.length; i++) {
      idList.add(meetingModel.value.meetingCoordinator![i].id!);
    }

    var res = await api.generateMultiNotifications(
        id: idList,
        type: 0,
        meeting_date: meetingModel.value.dateOfMeeting!,
        meeting_name: meetingModel.value.nameOfTheMeeting!,
        meeting_time: meetingModel.value.timeOfTheMeeting!);
  }

  generateTheNotificationsExternal() async {
    List<int> idList = [];

    for (var i = 0; i < meetingModel.value.siecParticipants!.length; i++) {
      idList.add(meetingModel.value.siecParticipants![i].id!);
    }

    for (var i = 0; i < meetingModel.value.meetingCoordinator!.length; i++) {
      idList.add(meetingModel.value.meetingCoordinator![i].id!);
    }

//todoImpo
    // var title = 'Scheduled a Meeting';
    // var body = "You have a meeting with SIEC Family, scheduled at ";

    var res = await api.generateMultiNotifications(
        type: 1,
        id: idList,
        meeting_date: meetingModel.value.dateOfMeeting!,
        meeting_name: meetingModel.value.nameOfTheMeeting!,
        meeting_time: meetingModel.value.timeOfTheMeeting!);
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

    // var data =
    //     List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    var data =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));
    print(data.toString());

    branchList = data;

    // allBranchList.value = data;

    update();
  }

  getBranchData2() async {
    // print('fvffg');
    var res = await api.allBranch2();

    // var data =
    //     List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)));

    var data = List<BranchWithImagesModel>.from(
        res.map((e) => BranchWithImagesModel.fromJson(e)));
    print(data.toString());

    branchListwithFlag = data;

    // allBranchList.value = data;

    update();
  }

  int selectedBranchForUserList = 0;
  branchSelected(codeID) async {
    selectedBranchForUserList = codeID;
    update();
    // print(val);
    // selectedBranch.value = val;
    // var branchCode = allBranchList.value.map(
    //     (e) => e.branchName!.toLowerCase() == val.toString().toLowerCase(),
    //     print(e));
    // print(branchCode);
    int code = codeID;
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
    if (data.length != 0) {
      preFilledUsers = await data[0].teamMembers!;
      // await List<AllUserModel>.from(data.map((e) => e.teamMembers!));

      selectedUsersList = preFilledUsers;
      print(preFilledUsers.toString());

      update();
    } else {
      preFilledUsers = [];
      selectedUsersList = [];
      update();
    }
    // change(preFilledUsers, status: RxStatus.success());

    // print(Get.find<DashBoardController>().listBro);

    // print(preFilledUsers.value.toString());
  }

  addNewAgenda({required agenda, required userId}) async {
    var res = await api.addAgenda(agenda: agenda, userId: userId);

    if (res != null) {
      // var con = Get.context;

      getAllAgenda();

      return true;
    }
  }

  List<String> agendaList = [];
  getAllAgenda() async {
    change(null, status: RxStatus.loading());
    var res = await api.allAgenda();

    agendaList = List<String>.from(res as List);
    change(null, status: RxStatus.success());

    update();
  }

  List<AllUserModel> bankVendorPersonNameDropDownList = [];

  fetchReprenestativeDropDownDataFromVendorBankGroup(
      String repType, String nameOfGroup) async {
    // print(meetingWith.value.substring(0, meetingWith.value.length - 8));
    // var data = meetingWith.value.split(' ')[0];
    // substring(0, meetingWith.value.length - 9);

    var res = await api.findRepresentativeForDropDownFromBankVendor(
        "$repType", nameOfGroup);

    bankVendorPersonNameDropDownList =
        List<AllUserModel>.from(res.map((e) => AllUserModel.fromJson(e)))
            .toList();

    update();
  }

  bool showRepresentativeData = false;
}
