import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:nice_loading_button/nice_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController with StateMixin {
  ApiServices api = ApiServices();
  bool verifyEmail = true;
  //// popup forget password
  RxInt forOtp = 0.obs;
  RxInt resendOTP = 0.obs;
  int otpSuccessful = 0;
  bool createPassword = false;
  bool passwordForget = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  var otpController = TextEditingController();
  var passwordController = TextEditingController();

  bool passwordValidatted = false;

  bool showPassword = false;

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
      var res2 = await api.getOTP(email);
      startTimer();
      // var res2 = true;

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

    change(null, status: RxStatus.success());
  }

//todo

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

    if (res == true) {
      forOtp.value = 1;
      otpSuccessful = 1;
      createPassword = true;

      // Get.to(CreatePasswrord(email: email));
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

  forgetPaasword(String email, BuildContext context) async {
    var res = await api.forgetpassword(email);
    if (res) {
      return true;
    }
  }

  updatePasswordForget(String email, String password, String otp) async {
    var res = await api.updatePasswordForget(email, otp, password);
    if (res != null) {
      return true;
    }
  }

  getDailogForForget(BuildContext context, String email,
      [bool passwordUpdate1 = false, String otp = ""]) {
    var emailController = TextEditingController();
    bool passwordUpdate = passwordUpdate1;
    emailController.text = email;
    otpController.text = otp;
    return showDialog(
      context: context,
      builder: (_) => Stack(
        children: [
          Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: CustomAutoSizeTextMontserrat(
                            text: 'Reset password',
                            fontSize: ThemeConstants.fontSizeMedium,
                          ),
                        ),
                        Spacer(),
                        // InkWell(
                        //   onTap: () {
                        //     context.pop();
                        //   },
                        //   child: Icon(
                        //     Icons.close,
                        //     color: ThemeConstants.bluecolor,
                        //     size: 16,
                        //   ),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          backgroundCOlour: ThemeConstants.whitecolor,
                          hint: "Enter your office email",
                          validator: Validator.email,
                          readOrEdit: true,
                          controller: emailController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          readOrEdit: passwordUpdate,
                          keybord: TextInputType.number,
                          backgroundCOlour: ThemeConstants.whitecolor,
                          hint: "Enter your OTP",
                          validator: Validator.otp,
                          controller: otpController),
                    ),
                    if (passwordUpdate == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 2),
                        child: LoadingButton(
                          height: 35,
                          borderRadius: 8,
                          animate: true,
                          width: MediaQuery.of(context).size.width * 0.55,
                          color: ThemeConstants.bluecolor,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          loader: Container(
                            padding: const EdgeInsets.all(5),
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ThemeConstants.bluecolor),
                            ),
                          ),
                          child: CustomAutoSizeTextMontserrat(
                            text: 'Veridy OTP',
                            textColor: ThemeConstants.whitecolor,
                            fontSize: ThemeConstants.fontSizeMedium,
                          ),
                          onTap:
                              (startLoading, stopLoading, buttonState) async {
                            // print(widget.path);

                            startLoading();

                            if (otpController.text.isEmpty) {
                              getToast("Kindly enter otp");
                            } else {
                              var res = await otpMatchForget(
                                  email, otpController.text);
                              if (res == true) {
                                getDailogForForget(
                                    context, email, true, otpController.text);
                                // setInnerState(() {});
                              }
                            }
                            // if (passwordController.text.isNotEmpty &&
                            //     otpController.text.isNotEmpty &&
                            //     passwordValidatted == true) {
                            //   var res = await updatePasswordForget(email,
                            //       passwordController.text, otpController.text);

                            //   if (res == true) context.pop();
                            // } else {
                            //   getToast("Kindly check your fields");
                            // }

                            stopLoading();
                          },
                        ),
                      ),
                    if (passwordUpdate == true)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextField(
                            backgroundCOlour: ThemeConstants.whitecolor,
                            hint: "Enter your password",
                            // validator: Validator.passwordWithSpecial,
                            controller: passwordController),
                      ),
                    if (passwordUpdate == true)
                      SizedBox(
                        height: 15,
                      ),
                    if (passwordUpdate == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: FlutterPwValidator(
                            controller: passwordController,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            lowercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            width: 300,
                            height: 150,
                            onSuccess: () {
                              passwordValidatted = true;
                              print('object');
                              update();
                            },
                            onFail: () {
                              print('object');
                              passwordValidatted = false;
                              update();
                            }),
                      ),
                    if (passwordUpdate == true)
                      SizedBox(
                        height: 15,
                      ),
                    if (passwordUpdate == true)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 2),
                        child: LoadingButton(
                          height: 35,
                          borderRadius: 8,
                          animate: true,
                          width: MediaQuery.of(context).size.width * 0.55,
                          color: ThemeConstants.bluecolor,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          loader: Container(
                            padding: const EdgeInsets.all(5),
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ThemeConstants.bluecolor),
                            ),
                          ),
                          child: CustomAutoSizeTextMontserrat(
                            text: 'Update Password',
                            textColor: ThemeConstants.whitecolor,
                            fontSize: ThemeConstants.fontSizeMedium,
                          ),
                          onTap:
                              (startLoading, stopLoading, buttonState) async {
                            // print(widget.path);

                            startLoading();
                            if (passwordController.text.isNotEmpty &&
                                otpController.text.isNotEmpty &&
                                passwordValidatted == true) {
                              var res = await updatePasswordForget(email,
                                  passwordController.text, otpController.text);

                              if (res == true) {
                                context.pop();
                                context.pop();
                              }
                            } else {
                              getToast("Kindly check your fields");
                            }

                            stopLoading();
                          },
                        ),
                      ),
                  ])),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                  otpController.clear();
                  passwordController.clear();
                  // Get.back();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: ThemeConstants.bluecolor,
                      borderRadius: BorderRadius.circular(200)),
                  child: Icon(
                    Icons.close_rounded,
                    color: ThemeConstants.whitecolor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ).whenComplete(() {
      otpController.clear();
      passwordController.clear();
    });
  }

  otpMatchForget(String email, String otp) async {
    var res = await api.otpMatchForget(email, otp);
    if (res != null) {
      return true;
    }
  }
}
