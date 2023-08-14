import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/dashboardNotesModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignToController extends GetxController with StateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    change(null, status: RxStatus.success());
  }

  ApiServices api = ApiServices();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String deadLine = DateTime.now().toString().substring(0, 10);

  AllUserModel taskOwner = AllUserModel();

  assign(FindNotesModel argu, task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getInt('id');

    print(id);
    var data = {
      "id": 1,
      "meeting_id": argu.meetingId,
      "meeting_notes_id": argu.id,
      "task_type": task,
      "deadline_date": deadLine,
      "task_owner_id": taskOwner.id,
      "is_active": true,
      "closed_at": "2023-04-07T09:48:35.000Z",
      "closed_by": 0,
      "meeting_attented": false,
      "reason_of_not_attended": "",
      "created_by": id,
      "updated_by": id,
      "created_at": "2023-04-07T09:48:35.000Z",
      "updated_at": "2023-04-07T09:48:35.000Z",
      "notes": argu.note
    };

    var res = await api.assignTo(data);
    if (res == true) {
      // Get.defaultDialog(
      //     content: Container(
      //   child: CustomAutoSizeTextMontserrat(text: 'Task Assigned Successfully'),
      // ));
    }
  }

  assign2(DashBoardNotes argu, task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = await prefs.getInt('id');

    print(id);
    var data = {
      "id": 1,
      "meeting_id": argu.meetingId,
      "meeting_notes_id": argu.id,
      "task_type": task,
      "deadline_date": deadLine ?? DateTime.now().day,
      "task_owner_id": taskOwner.id,
      "is_active": true,
      "closed_at": "2023-04-07T09:48:35.000Z",
      "closed_by": 0,
      "meeting_attented": false,
      "reason_of_not_attended": "",
      "created_by": id,
      "updated_by": id,
      "created_at": "2023-04-07T09:48:35.000Z",
      "updated_at": "2023-04-07T09:48:35.000Z",
      "notes": null
    };

    var res = await api.assignTo(data);
    if (res == true) {
      Get.defaultDialog(
          content: Container(
        child: CustomAutoSizeTextMontserrat(text: 'Task Assigned Successfully'),
      ));
    }
  }
}
