import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/services/apiServices.dart';

class CreateNewMeetingController extends GetxController {
  Rx<TextEditingController> meetingNameController = TextEditingController().obs;
  // Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> proposedDuration = TextEditingController().obs;
  Rx<TextEditingController> meetingLink = TextEditingController().obs;
  RxBool externalMeeting = false.obs;
  Rx<AllMeetings> meetingModel = AllMeetings().obs;
  ApiServices api = ApiServices();

  RxString agendaPurposeOfMeeting = 'All Meetings'.obs;

  RxString dateController = ''.obs;

  // RxString proposedDuration = ''.obs;

  List<String> list = <String>[
    'All Meetings',
    'University Meeting',
    'Bank Meeting',
    'Vendor Meeting',
    'Internal Meeting'
  ];

  List<String> selectTargetAudienceType = <String>[
    'Select Target Audience Type',
    'Group Wise',
    'Branch Based',
    'User Based',
    'All User'
  ];

  List<String> groupNamesAudienceType = <String>[
    'IT Team',
    'Australia Applications',
    'SSU Team',
    'Canada Advisors',
    'Europe Team'
  ];

  RxBool MeetingType = true.obs;
  RxBool meetingLocation = true.obs;
  RxString selectedTargetAudience = ''.obs;

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
