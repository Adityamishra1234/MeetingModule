import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';
import 'package:meeting_module2/main.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseController extends GetxController {
  ApiServices api = ApiServices();

  Rx<UserModel> user = UserModel().obs;

  List<AllUserModel> allSiecMembersList = <AllUserModel>[];

  Rx<AllMeetings> meetingData = AllMeetings().obs;

  int id = 0;
  String token = '';

  StreamSubscription? connectionStream;

  bool connectedToInternet = false;

  connection() {
    connectionStream = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        connectedToInternet = true;
        // currentPageBuildContext!.go('/MeetingDetails');
        update();
      } else {
        currentPageBuildContext!.go('/MeetingDetails');

        connectedToInternet = false;
        update();
      }
    });
  }

  BuildContext? currentPageBuildContext;
  getBuildContextOfThePage(BuildContext context) {
    currentPageBuildContext = context;
  }

  @override
  void onInit() async {
    connection();

    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();
    await getId();
    // await checkUser();
    await getAllSiecMembersList();

    // getNotes('1');
  }

  Future<void> hideScreen() async {
    if (GetPlatform.isIOS) {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        FlutterSplashScreen.hide();
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        FlutterSplashScreen.hide();
      });
    }
  }

  AllMeetings selectedMeetingData = AllMeetings();

  selectedMeeting(AllMeetings data) {
    selectedMeetingData = data;
  }

  Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt('id') == null) {
      id = 0;
    } else {
      id = prefs.getInt('id')!;
    }

    print('$id dddvfvfvd');

    if (await prefs.getString('token') == null) {
      print('dd');
    } else {
      token = await prefs.getString('token')!;
    }

    return id;
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(SignInView.route);
    // Get.offAllNamed(SignInView.route);
  }

  token2() async {
    print(token + 'ddddd');
    if (token != '') {
      var data = await api.updateFCMToken(id, token);

      await sendPushMessage(token);
    }
  }

  getAllSiecMembersList() async {
    var res2 = await api.getDropdown(Endpoints.allUser);

    var allUserList = await List<AllUserModel>.from(
        res2.map((x) => AllUserModel.fromJson(x)));

    allSiecMembersList =
        List<AllUserModel>.from(allUserList.map((element) => element)).toList();
  }

  // checkUser() async {
  //   print(id);
  //   if (id != 0) {
  //     await Future.delayed(Duration(seconds: 1));
  //     hideScreen();
  //     BuildContext conte = Get.context!;

  //     GoRouter.of(conte).go(DashBoard.routeNamed);
  //     // Get.offAllNamed(DashBoard.routeNamed);
  //   } else {
  //     await Future.delayed(Duration(seconds: 1));
  //     hideScreen();
  //   }
  // }
}
