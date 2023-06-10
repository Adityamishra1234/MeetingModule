import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';

class LoginController extends GetxController with StateMixin {
  ApiServices api = ApiServices();
  int forOtp = 0;
  bool verifyEmail = true;
  int resendOTP = 0;
  int otpSuccessful = 0;
  bool createPassword = false;
  bool passwordCreatedSuccessful = false;

  bool showPassword = false;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  emailVerification(String email) async {
    // var res = false;
    var res = await api.getEmailverification(email);

    if (res != null) {
      verifyEmail = false;
      forOtp = 2;

      update();
      // var res2 = await api.getOTP(email);
      startTimer();
      var res2 = true;

      update();
    }
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
    // var res = await api.otpMatch(email, otp);
    var res = true;

    if (res != null) {
      if (res == true) {
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
      Get.defaultDialog(
        title: 'Registeration Successfull',
        content: Container(
          child: Icon(
            Icons.check,
            color: ThemeConstants.GreenColor,
            size: 30,
          ),
        ),
      );

      // Get.offNamed(LoginPage.routeNamed);
    }

    // Get.toNamed(DashBoard.routeNamed);
  }
}
