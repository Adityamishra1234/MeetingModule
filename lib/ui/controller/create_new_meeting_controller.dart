import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/services/apiServices.dart';

class CreateNewMeetingController extends GetxController {
  RxString agendaPurposeOfMeeting = 'All Meetings'.obs;

//
//
  Rx<TextEditingController> meetingNameController = TextEditingController().obs;
//
//
  RxString dateController = ''.obs;
  //
  //
  RxString timeController = ''.obs;

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

  RxList<String> selectedUsersList = <String>[].obs;

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
    print(selectedTargetAudience);
    meetingModel.value.nameOfTheMeeting = meetingNameController.value.text;
    print(meetingNameController.value.text);
    print(dateController.value);
    // meetingModel.value.dateOfMeeting = dateController.value.text;

    meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;

    // var res = await api.createMeeting(meetingModel.value);
    // print(res);

    // meetingModel.value.timeOfTheMeeting = meetingNameController.value.text;
  }
}
