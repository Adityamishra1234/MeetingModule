import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/main.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/services/endpoints.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseController extends GetxController {
  ApiServices api = ApiServices();

  Rx<UserModel> user = UserModel().obs;

  List<AllUserModel> allSiecMembersList = <AllUserModel>[];

  Rx<AllMeetings> meetingData = AllMeetings().obs;

  int id = 0;
  String token = '';

  @override
  void onInit() async {
    // await Future.delayed(Duration(seconds: 5));
    // RxStatus.loading();5
    super.onInit();
    await getId();
    await checkUser();
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

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('id') == null) {
      id = 0;
    } else {
      id = prefs.getInt('id')!;
    }

    if (await prefs.getString('token') == null) {
      print('dd');
    } else {
      token = await prefs.getString('token')!;
    }
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

  checkUser() async {
    print(id);
    if (id != 0) {
      Get.offNamed(DashBoard.routeNamed);
    }
    await Future.delayed(Duration(seconds: 1));
    hideScreen();
  }
}
