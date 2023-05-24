import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardController extends GetxController with StateMixin {
  ApiServices api = ApiServices();

  RxString selectedFilter = 'All Meetings'.obs;

  List<AllMeetings> allMeetingslist = [];

  RxInt indexOfTab = 0.obs;

  // RxList<AllMeetings> listToShowBackup = <AllMeetings>[].obs;

  // List<AllMeetings> doneMeetings = [];

  // List<AllMeetings> upcomingMeetings = [];

  RxList<AllMeetings> listToShow = <AllMeetings>[].obs;

  RxList<AllUserModel> allUserList = <AllUserModel>[].obs;

  RxList<AllUserModel> listBro = <AllUserModel>[].obs;

  RxList<FindNotesModel> notesList = <FindNotesModel>[].obs;

  // RxList<AllMeetings> internalMeetingList = <AllMeetings>[].obs;

  // RxList<AllMeetings> externalMeetingList = <AllMeetings>[].obs;

  RxBool loading = false.obs;

  RxBool loading1 = false.obs;
  var helo = 0.obs;

  @override
  void onInit() async {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();
    print('fff');

    helo.value = 2;
    await getsss();
    getNotes('1', null);
  }

  frfr(val) {
    print('$val dcdcd');
    selectedFilter.value = val;
    print(selectedFilter.value);
    update();
  }

  Rx<UserModel> user = UserModel().obs;

  getsss() async {
    // RxStatus.loading();
    // print('dddd');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getInt('id');
    print(id);
    var res = await api.getAllMeetings(id!);

    if (res != false) {
      var data = await json.decode(res);

      allMeetingslist = await List<AllMeetings>.from(
          data.map((x) => AllMeetings.fromJson(x)));

      RxList<AllMeetings> userID = <AllMeetings>[].obs;
      showUpcomingList();
    }

    var email = await prefs.getString('email');
    var password = await prefs.getString('password');

    var login = await api.login(email: email!, password: password!);

    var data = json.decode(login);

    user.value = UserModel.fromJson(data);

    change(null, status: RxStatus.success());

//     allMeetingslist.forEach((e) {

// userID.add(item);
//       e.siecParticipants!.where((element) => element.id == userID);
//       e.meetingCoordinator!.where((element) => element.id == userID);
//     });

    // var res2 = await api.getDropdown(Endpoints.allUser);

    // var data2 = await json.decode(res2);

    // allUserList.value = await List<AllUserModel>.from(
    //     data2.map((x) => AllUserModel.fromJson(x)));

    // listBro.value =
    //     List<AllUserModel>.from(allUserList.map((element) => element)).toList();
    // loading1.value = true;

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

  Rx<AllMeetings> selectedMeetingdata = AllMeetings().obs;

  getNotes(String id, int? index) async {
    if (index != null) {
      selectedMeetingdata.value = listToShow[index];
    }
    var res = await api.findNotes(id);

    print('res');

    var data2 = await json.decode(res);

    print(data2);

    // List<FindNotesModel> data = List<FindNotesModel>.from(
    //     json.decode(res).map((x) => FindNotesModel.fromJson(x)));

    var data =
        List<FindNotesModel>.from(data2.map((x) => FindNotesModel.fromJson(x)));
    notesList.value = data;
  }

  RxBool upcomingbuttonEnable = true.obs;

  // internalMeeting() {
  //   internalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'Internal Meeting')
  //       .toList();
  // }

  // enternalMeeting() {
  //   externalMeetingList.value = allMeetingslist
  //       .where((ele) => ele.meetingType == 'External Meeting')
  //       .toList();
  // }

  changeInFilter() async {
    if (indexOfTab.value == 0) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow.value = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == false,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'University Meetings' &&
                p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow.value = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == false)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 's' &&
                p0.meetingEnded == false &&
                p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == false)
            .toList();
      }
    } else if (indexOfTab.value == 1) {
      if (selectedFilter.value == "All Meetings") {
        // print('dcdcd');
        listToShow.value = await allMeetingslist
            .where(
              (ele) => ele.meetingEnded == true,
            )
            .toList();
      } else if (selectedFilter.value == "University Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 'University Meetings' &&
                p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Vendor Meeting") {
        listToShow.value = await allMeetingslist
            .where(
                (p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
            .toList();
      } else if (selectedFilter.value == "Internal Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) =>
                p0.meetingWith == 's' &&
                p0.meetingEnded == true &&
                p0.meetingType == 'Internal Meeting')
            .toList();
      } else if (selectedFilter.value == "Bank Meeting") {
        listToShow.value = await allMeetingslist
            .where((p0) => p0.meetingWith == 'bank' && p0.meetingEnded == true)
            .toList();
      }
    }
  }

  showUpcomingList() async {
    // print('ddd');

    changeInFilter();
  }

  // upcomingMeetings;
  //   await Future.delayed(Duration(seconds: 2));

  //   // change(listToShow, status: RxStatus.success());
  //   loading.value = false;
  //   // update();
  // }

  showDoneList() async {
    changeInFilter();
    loading.value = false;
    print('ddddd');

    // listToShow.value = doneMeetings;

    // if (selectedFilter.value == "All Meetings") {
    //   listToShow.value = await allMeetingslist
    //       .where(
    //         (ele) => ele.meetingEnded == false,
    //       )
    //       .toList();
    // } else if (selectedFilter.value == "University Meeting") {
    //   listToShow.value = await internalMeetingList
    //       .where(
    //           (p0) => p0.meetingWith == 'university' && p0.meetingEnded == true)
    //       .toList();
    // } else if (selectedFilter.value == "Vendor Meeting") {
    //   listToShow.value = await internalMeetingList
    //       .where((p0) => p0.meetingWith == 'vendor' && p0.meetingEnded == true)
    //       .toList();
    // }

    // // upcomingMeetings;
    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;

    // showSpecificMeeting(value) async {
    //   listToShowBackup = listToShow;

    //   if (selectedFilter.value == 'Vendor Meeting') {
    //     listToShow.value = await listToShowBackup
    //         .where(
    //           (ele) => ele.meetingEnded == true && ele.meetingWith == 'vendor',
    //         )
    //         .toList();

    //     update();
    //   }
    // }

    // await Future.delayed(Duration(seconds: 2));

    // // change(listToShow, status: RxStatus.success());
    // loading.value = false;
    // // change(loading, status: RxStatus.success());
    // update();
  }
}
