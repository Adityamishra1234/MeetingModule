import 'dart:convert';

import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/services/apiServices.dart';

class DashBoardController extends GetxController with StateMixin {
  ApiServices api = ApiServices();

  List<AllMeetings> allMeetingslist = [];

  List<AllMeetings> doneMeetings = [];

  List<AllMeetings> upcomingMeetings = [];

  RxList<AllMeetings> listToShow = <AllMeetings>[].obs;

  RxBool loading = false.obs;

  var helo = 0.obs;

  @override
  void onInit() async {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5

    helo.value = 2;
    await getsss();

    super.onInit();
    // change(listToShow, status: RxStatus.success());
  }

  getsss() async {
    loading.value = true;
    // RxStatus.loading();
    // print('dddd');
    var res = await api.getAllMeetings();
    var data = await json.decode(res);
    allMeetingslist =
        await List<AllMeetings>.from(data.map((x) => AllMeetings.fromJson(x)));

    // list = await data;
    print(allMeetingslist);

    // allMeetingslist.where((element) {
    //   print(element);
    //   if (element.meetingEnded == true) {
    //     print(element);
    //     doneMeetings.add(element);
    //   }

    //   return true;
    // });
    // print(doneMeetings.length);

    for (var i = 0; i < allMeetingslist.length; i++) {
      if (allMeetingslist[i].meetingEnded == true) {
        doneMeetings.add(allMeetingslist[i]);
        print(doneMeetings);
      } else {
        upcomingMeetings.add(allMeetingslist[i]);
      }
    }
    loading.value = false;

    listToShow.value = upcomingMeetings;
    update();
  }

  showUpcomingList() async {
    print('ddd');
    loading.value = true;
    listToShow.value = upcomingMeetings;
    // change(listToShow, status: RxStatus.success());
    loading.value = false;
    update();
  }

  showDoneList() async {
    loading.value = true;
    print('ddddd');

    listToShow.value = doneMeetings;

    await Future.delayed(Duration(seconds: 2));

    // change(listToShow, status: RxStatus.success());
    loading.value = false;
    // change(loading, status: RxStatus.success());
    update();
  }

  RxBool upcomingbuttonEnable = true.obs;
}
