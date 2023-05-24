import 'dart:convert';

import 'package:get/get.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/utils/constants.dart';
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
    print(res == true.toString());
    if (res != null) {
      if (res == false.toString()) {
        getToast("Not registered Please register first");
      } else if (res == true.toString()) {
        verifyEmail = false;
        forOtp.value = 2;

        update();
        // var res2 = await api.getOTP(email);
        startTimer();
        var res2 = true;
        if (res2 != null) {
          if (res2 == true) {
            getToast("Please check otp on your office email address");
            forOtp.value = 2;
          } else {
            getToast("Some thing went wrong");
          }
        }
        print('object');
        getToast('Already Registered Please check forget password');
      } else if (res == 'User not found') {
        getToast('Please Contact HR');
      }
    }

    update();
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

  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getInt('id');
    print(data);
    if (data != null) {
      Get.to(DashBoard());
    }
  }

  updatePassword(String email, String password) async {
    var res = await api.password(email, password);
    print(res);
    if (res != null) {
      if (res == true) {
        // Get.offNamed(LoginPage.routeNamed);
      }
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
    var res = await api.login(email: email, password: password);

    if (res.toString().toLowerCase() == 'User Not Found'.toLowerCase()) {
      getToast('Please contact your HR');
    } else if (res.toString().toLowerCase() == 'Wrong Password'.toLowerCase()) {
      getToast('Wrong Password');
    } else {
      var data = json.decode(res);

      UserModel data2 = UserModel.fromJson(data);

      print(data2);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setInt('id', data2.id!);
      await prefs.setString('password', password);

      Get.to(DashBoard());

      return data2;
    }
  }
}
