import 'dart:convert';

import 'package:get/get.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController with StateMixin {
  ApiServices api = ApiServices();
  bool verifyEmail = true;
  //// popup forget password
  RxInt forOtp = 0.obs;
  RxInt resendOTP = 0.obs;
  int otpSuccessful = 0;
  bool createPassword = false;

  startResend() async {
    // var res2 = await api.getOTP(email);
    timer.value = 10;
    startTimer();
    update();
  }

  emailVerification(String email) async {
    // var res = false;
    var res = await api.getEmailverification(email);

    if (res != null) {
      verifyEmail = false;
      forOtp.value = 2;

      update();
      // var res2 = await api.getOTP(email);
      startTimer();
      var res2 = true;

      update();
    }
  }

  RxInt timer = 10.obs;
  startTimer() async {
    resendOTP.value = 2;

    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      if (timer.value != 0) {
        timer.value = timer.value - 1;
        print(timer.value);
      }
    }

    resendOTP.value = 1;
    update();

    return null;
  }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    // TODO: implement onInit
    super.onInit();
    await checkUser();
    change(null, status: RxStatus.success());
  }

//todo
  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getInt('id');
    print(data);
    if (data != null) {
      Get.off(DashBoard());
    }
  }

  updatePassword(String email, String password) async {
    var res = await api.password(email, password);
    print(res);
    if (res != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var data = await prefs.setString('email', email);
      var data2 = await prefs.setString('password', password);

      return true;
      // Get.offNamed(LoginPage.routeNamed);
    }

    // Get.toNamed(DashBoard.routeNamed);
  }

  otpcheck(String email, String otp) async {
    change(null, status: RxStatus.loading());
    // var res = await api.otpMatch(email, otp);
    var res = true;

    if (res != null) {
      if (res == true) {
        forOtp.value = 1;
        otpSuccessful = 1;
        createPassword = true;

        // Get.to(CreatePasswrord(email: email));
      }
    }

    update();

    change(null, status: RxStatus.success());
  }

  logIn(String email, String password) async {
    if (email.isEmpty) {
      getToast('${SnackBarConstants.requiredFields}');
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
