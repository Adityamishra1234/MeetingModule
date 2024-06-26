import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/backgroundLogin.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeNamed = '/LoginPage';

  TextEditingController texfield = TextEditingController();
  TextEditingController otpfield = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  var controllerBase = Get.put(BaseController(), permanent: true);
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: controller.obx(
          (state) => Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  BackgroundAuthView(
                    text: "Let's Register you ",
                  ),
                  // Positioned(
                  //     width: MediaQuery.of(context).size.width * 1,
                  //     height: MediaQuery.of(context).size.height * 0.7,
                  //     top: MediaQuery.of(context).size.height * 0.3,
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           color: ThemeConstants.midVioltetColor,
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(180),
                  //             topRight: Radius.circular(180),
                  //           )),
                  //     )),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.bottomCenter,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.key,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(215, 5, 38, 129),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                // SizedBox(
                                //     height: 150,
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       children: [
                                //         CustomAutoSizeTextMontserrat(
                                //           text: 'Welcome!',
                                //           fontSize: 30,
                                //         ),
                                //         CustomAutoSizeTextMontserrat(
                                //           text: "Lets's Register you",
                                //           fontSize: 20,
                                //         )
                                //       ],
                                //     )),
                                // SizedBox(
                                //   height: 0,
                                // ),
                                // SizedBox(
                                //     width: 350,
                                //     height: 350,
                                //     child: Image.asset(
                                //         'assets/images/Login-Image.png')),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 10),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: 'Register',
                                    textColor: ThemeConstants.whitecolor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: CustomTextField(
                                      backgroundCOlour:
                                          ThemeConstants.whitecolor,
                                      hint: "Enter your office email",
                                      validator: Validator.email,
                                      controller: texfield),
                                ),
                                if (controller.verifyEmail == true)
                                  InkWell(
                                    onTap: () {
                                      if (controller.key.currentState!
                                          .validate()) {
                                        print('dd');
                                        controller
                                            .emailVerification(texfield.text);
                                      }

                                      //   email: texfield.text,
                                      // ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 80),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                            color:
                                                ThemeConstants.lightVioletColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Verify Email",
                                            textColor:
                                                ThemeConstants.blackcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (controller.forOtp == 1 ||
                                    controller.forOtp == 2)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: CustomTextField(
                                        backgroundCOlour:
                                            ThemeConstants.whitecolor,
                                        hint: "enter your OTP",
                                        validator: Validator.otp,
                                        controller: otpfield),
                                  ),
                                if (controller.resendOTP == 2 ||
                                    controller.resendOTP == 1)
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        if (controller.resendOTP == 1)
                                          controller.startResend();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 30),
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Resend OTP ${controller.timer.value == 0 ? '' : controller.timer.value}",
                                            style: TextStyle(
                                                fontWeight:
                                                    controller.resendOTP == 1
                                                        ? FontWeight.w500
                                                        : FontWeight.bold,
                                                color: controller.resendOTP == 1
                                                    ? ThemeConstants.GreenColor
                                                    : ThemeConstants.bluecolor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                if (controller.forOtp == 2)
                                  InkWell(
                                    onTap: () {
                                      if (controller.key.currentState!
                                          .validate()) {
                                        controller.otpcheck(
                                            texfield.text, otpfield.text);
                                      }
                                      // Get.to(CreatePasswrord(
                                      //   email: texfield.text,
                                      // ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 80),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                            color:
                                                ThemeConstants.lightVioletColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Verify OTP",
                                            textColor:
                                                ThemeConstants.blackcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (controller.otpSuccessful == 1) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: CustomTextField(
                                        backgroundCOlour:
                                            ThemeConstants.whitecolor,
                                        obscureText: true,
                                        validator:
                                            Validator.passwordWithSpecial,
                                        hint: "Please enter your password",
                                        // validator: Validator.email,
                                        controller: password),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: CustomTextField(
                                        backgroundCOlour:
                                            ThemeConstants.whitecolor,
                                        obscureText: true,
                                        validator:
                                            Validator.passwordWithSpecial,
                                        hint:
                                            "Please enter your confirm password",
                                        // validator: Validator.email,
                                        controller: confirmpassword),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.key.currentState!
                                          .validate()) {
                                        if (confirmpassword.text !=
                                            password.text) {
                                          return getToast(
                                              '${SnackBarConstants.passwordNotMatching}');
                                        }

                                        //todo
                                        if (password.text ==
                                            confirmpassword.text) {
                                          var res = controller.updatePassword(
                                              texfield.value.text,
                                              password.text);

                                          if (res) {
                                            // controller.onDelete();
                                            // Get.put(LoginController());
                                          }
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 80),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                            color:
                                                ThemeConstants.lightVioletColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Register",
                                            textColor:
                                                ThemeConstants.blackcolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                // if (controller.showRegister == true)
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed(SignInView.route);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Already validated your account? Click here.",
                                        style: TextStyle(
                                            color: ThemeConstants
                                                .lightVioletColor),
                                      ),
                                    ),
                                  ),
                                ),
                                // if (controller.passwordCreatedSuccessful == true)
                                //   InkWell(
                                //     onTap: () {
                                //       print('dd');
                                //       controller.emailVerification(texfield.text);

                                //       //   email: texfield.text,
                                //       // ));
                                //     },
                                //     child: Container(
                                //       height: 40,
                                //       width: MediaQuery.of(context).size.width - 20,
                                //       decoration: BoxDecoration(
                                //           color: ThemeConstants.bluecolor,
                                //           borderRadius:
                                //               BorderRadius.all(Radius.circular(20.0))),
                                //       child: Center(
                                //         child: CustomAutoSizeTextMontserrat(
                                //           text: "Register",
                                //           textColor: ThemeConstants.whitecolor,
                                //         ),
                                //       ),
                                //     ),
                                //   ),

                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
          onLoading: getLoading(context)),
    );
  }
}
