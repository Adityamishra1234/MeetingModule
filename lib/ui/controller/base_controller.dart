import 'dart:convert';

import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';

class BaseController extends GetxController {
  ApiServices api = ApiServices();

  Rx<UserModel> user = UserModel().obs;

  RxList<AllUserModel> allSiecMembersList = <AllUserModel>[].obs;

  Rx<AllMeetings> meetingData = AllMeetings().obs;

  @override
  void onInit() {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();

    getAllSiecMembersList();

    // getNotes('1');
  }

  getAllSiecMembersList() async {
    // RxStatus.loading();
    // print('dddd');
    // var res = await api.getAllMeetings();
    // var data = await json.decode(res);
    // allMeetingslist =
    //     await List<AllMeetings>.from(data.map((x) => AllMeetings.fromJson(x)));

    var res2 = await api.getDropdown(Endpoints.allUser);

    var allUserList = await List<AllUserModel>.from(
        res2.map((x) => AllUserModel.fromJson(x)));

    allSiecMembersList.value =
        List<AllUserModel>.from(allUserList.map((element) => element)).toList();

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

    // listToShow.value = upcomingMeetings;

    // update();
  }
}
