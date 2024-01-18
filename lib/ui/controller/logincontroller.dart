import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with StateMixin {
  ApiServices api = ApiServices();
  int forOtp = 0;
  bool verifyEmail = true;
  int resendOTP = 0;
  int otpSuccessful = 0;
  bool createPassword = false;
  bool passwordCreatedSuccessful = false;

  bool showPassword = false;

  bool passwordValidated = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    change(null, status: RxStatus.success());
  }

  emailVerification(String email) async {
    // var res = false;
    var res = await api.getEmailverification(email);

    if (res['success'] == true) {
      var res2 = await api.getOTP(email);

      if (res2['success'] == true) {
        // if (true) {
        verifyEmail = false;
        forOtp = 2;

        startTimer();
        // var res2 = true;
      }
    }

    update();
  }

  startResend() async {
    // var res2 = await api.getOTP(email);
    timer.value = 10;
    startTimer();
    update();
  }

  RxInt timer = 10.obs;
  startTimer() async {
    resendOTP = 2;

    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      if (timer.value != 0) {
        timer.value = timer.value - 1;
        print(timer.value);
      }
    }

    resendOTP = 1;
    update();

    return null;
  }

  otpcheck(String email, String otp) async {
    change(null, status: RxStatus.loading());
    var res = await api.otpMatch(email, otp);
    // var res = true;

    if (res != null) {
      // if (res['success'] == true) {
      if (true) {
        forOtp = 1;
        otpSuccessful = 1;
        createPassword = true;

        // Get.to(CreatePasswrord(email: email));
      }
    }

    update();

    change(null, status: RxStatus.success());
  }

  updatePassword(String email, String password) async {
    var res = await api.password(email, password);
    print(res);
    if (res != null) {
      var res = await logIn(email, password);
      if (res != false) {
        Get.find<BaseController>().user.value = res;

        return true;

        // Get.offAllNamed(DashBoard.routeNamed);
      }
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("email", email);
      // await prefs.setInt('id', data2.id!);
      // await prefs.setString('password', password);
      // Get.defaultDialog(
      //   title: 'Registration Successful',
      //   content: Container(
      //     child: Icon(
      //       Icons.check,
      //       color: ThemeConstants.GreenColor,
      //       size: 30,
      //     ),
      //   ),
      // );

      // Get.offNamed(LoginPage.routeNamed);
    }

    // Get.toNamed(DashBoard.routeNamed);
  }

  logIn(String email, String password) async {
    if (email.isEmpty) {
      // getToast('${SnackBarConstants.requiredFields}');
      return false;
    }

    var res = await api.login(email: email, password: password);

    if (res != null) {
      // if (res.toString().toLowerCase() == 'User Not Found'.toLowerCase()) {
      //   getToast('${SnackBarConstants.errorUserNotFound}');
      //   return false;
      // } else if (res.toString().toLowerCase() ==
      //     'Wrong Password'.toLowerCase()) {
      //   getToast('${SnackBarConstants.wrongPassword}');
      //   return false;
      // } else {
      // var data = json.decode(res);

      print(res);
      UserModel data2 = UserModel.fromJson(res);

      // print(data2);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setInt('id', data2.id!);
      await prefs.setString('password', password);

      return data2;

      // }
    } else {
      return false;
    }
  }
}
