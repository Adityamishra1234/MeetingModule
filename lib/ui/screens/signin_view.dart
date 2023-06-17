import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:nice_loading_button/nice_loading_button.dart';

import 'package:get/get.dart';
import 'package:meeting_module2/models/userModal.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';

import 'package:meeting_module2/ui/controller/signin_controller.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/ui/screens/loginUi.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class SignInView extends StatelessWidget {
  static const route = '/signin';
  SignInView({super.key});

  var controllerBase = Get.put(BaseController(), permanent: true);
  var controller = Get.put(SigninController());

  TextEditingController password = TextEditingController();

  TextEditingController otpfield = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();

  var emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
          (state) => Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.7,
                      // bottom: 0,
                      top: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeConstants.midVioltetColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(180),
                              topRight: Radius.circular(180),
                            )),
                      )),
                  SingleChildScrollView(
                    child: Container(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: 'Welcome!',
                                    fontSize: 30,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Lets's Sign you in",
                                    fontSize: 20,
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 0,
                          ),
                          SizedBox(
                              width: 350,
                              height: 350,
                              child:
                                  Image.asset('assets/images/Login-Image.png')),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomAutoSizeTextMontserrat(
                              text: 'Sign In',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomTextField(
                                hint: "Enter your office email",
                                validator: Validator.email,
                                backgroundCOlour: ThemeConstants.whitecolor,
                                controller: emailController),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomTextField(
                                hint: "Enter your password",
                                backgroundCOlour: ThemeConstants.whitecolor,
                                validator: Validator.password,
                                controller: password),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                          content: Obx(
                                        () => Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child:
                                                      CustomAutoSizeTextMontserrat(
                                                    text: 'Reset password',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: CustomTextField(
                                                      backgroundCOlour:
                                                          ThemeConstants
                                                              .whitecolor,
                                                      hint:
                                                          "Enter your office email",
                                                      validator:
                                                          Validator.email,
                                                      controller:
                                                          emailController),
                                                ),
                                                if (controller.verifyEmail ==
                                                    true)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40,
                                                        vertical: 2),
                                                    child: LoadingButton(
                                                      height: 35,
                                                      borderRadius: 8,
                                                      animate: true,
                                                      color: ThemeConstants
                                                          .bluecolor,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      loader: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: 40,
                                                        height: 40,
                                                        child:
                                                            const CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      child:
                                                          CustomAutoSizeTextMontserrat(
                                                        text: 'Check Email',
                                                        textColor:
                                                            ThemeConstants
                                                                .whitecolor,
                                                      ),
                                                      onTap: (startLoading,
                                                          stopLoading,
                                                          buttonState) async {
                                                        // print(widget.path);
                                                        if (buttonState ==
                                                            ButtonState.idle) {
                                                          startLoading();
                                                          await controller
                                                              .emailVerification(
                                                                  emailController
                                                                      .text);

                                                          // var res = await controller.logIn(
                                                          //     emailController.value.text,
                                                          //     password.value.text);

                                                          // if (res) {
                                                          //   controllerBase.user.value = res;
                                                          // }
                                                          // await download(widget.path);
                                                          // await Future.delayed(const Duration(seconds: 5))
                                                          stopLoading();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                // InkWell(
                                                //   onTap: () {
                                                //     print('dd');
                                                //     controller.emailVerification(
                                                //         emailController.text);

                                                //     //   email: texfield.text,
                                                //     // ));
                                                //   },
                                                //   child: Container(
                                                //     height: 40,
                                                //     width: MediaQuery.of(context)
                                                //             .size
                                                //             .width -
                                                //         20,
                                                //     decoration: BoxDecoration(
                                                //         color: ThemeConstants.bluecolor,
                                                //         borderRadius: BorderRadius.all(
                                                //             Radius.circular(20.0))),
                                                //     child: Center(
                                                //       child: CustomAutoSizeTextMontserrat(
                                                //         text: "Verify Email",
                                                //         textColor:
                                                //             ThemeConstants.whitecolor,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                if (controller.forOtp.value ==
                                                        1 ||
                                                    controller.forOtp.value ==
                                                        2)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: CustomTextField(
                                                        hint: "enter your OTP",
                                                        validator:
                                                            Validator.otp,
                                                        controller: otpfield),
                                                  ),
                                                if (controller.resendOTP == 2 ||
                                                    controller.resendOTP == 1)
                                                  Obx(
                                                    () => GestureDetector(
                                                      onTap: () {
                                                        if (controller
                                                                .resendOTP ==
                                                            1)
                                                          controller
                                                              .startResend();
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5,
                                                                horizontal: 20),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "Resend OTP ${controller.timer.value == 0 ? '' : controller.timer.value}",
                                                            style: TextStyle(
                                                                fontWeight: controller
                                                                            .resendOTP ==
                                                                        1
                                                                    ? FontWeight
                                                                        .w500
                                                                    : FontWeight
                                                                        .bold,
                                                                color: controller
                                                                            .resendOTP ==
                                                                        1
                                                                    ? ThemeConstants
                                                                        .GreenColor
                                                                    : ThemeConstants
                                                                        .bluecolor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (controller.forOtp == 2)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40,
                                                        vertical: 2),
                                                    child: LoadingButton(
                                                      height: 35,
                                                      borderRadius: 8,
                                                      animate: true,
                                                      color: ThemeConstants
                                                          .bluecolor,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.44,
                                                      loader: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        width: 40,
                                                        height: 40,
                                                        child:
                                                            const CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      child:
                                                          CustomAutoSizeTextMontserrat(
                                                        text: 'Verify OTP',
                                                        textColor:
                                                            ThemeConstants
                                                                .whitecolor,
                                                      ),
                                                      onTap: (startLoading,
                                                          stopLoading,
                                                          buttonState) async {
                                                        // print(widget.path);
                                                        if (buttonState ==
                                                            ButtonState.idle) {
                                                          startLoading();
                                                          await controller
                                                              .otpcheck(
                                                                  emailController
                                                                      .text,
                                                                  otpfield
                                                                      .text);

                                                          // var res = await controller.logIn(
                                                          //     emailController.value.text,
                                                          //     password.value.text);

                                                          // if (res) {
                                                          //   controllerBase.user.value = res;
                                                          // }
                                                          // await download(widget.path);
                                                          // await Future.delayed(const Duration(seconds: 5))
                                                          stopLoading();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                // InkWell(
                                                //   onTap: () {
                                                //     controller.otpcheck(
                                                //         emailController.text,
                                                //         otpfield.text);

                                                //     // Get.to(CreatePasswrord(
                                                //     //   email: texfield.text,
                                                //     // ));
                                                //   },
                                                //   child: Container(
                                                //     height: 40,
                                                //     width: MediaQuery.of(context)
                                                //             .size
                                                //             .width -
                                                //         20,
                                                //     decoration: BoxDecoration(
                                                //         color: ThemeConstants.bluecolor,
                                                //         borderRadius: BorderRadius.all(
                                                //             Radius.circular(20.0))),
                                                //     child: Center(
                                                //       child: CustomAutoSizeTextMontserrat(
                                                //         text: "Verify OTP",
                                                //         textColor:
                                                //             ThemeConstants.whitecolor,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                if (controller.otpSuccessful ==
                                                    1) ...[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: CustomTextField(
                                                        obscureText: true,
                                                        validator:
                                                            Validator.password,
                                                        hint:
                                                            "Please enter your password",
                                                        // validator: Validator.email,
                                                        controller: password),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: CustomTextField(
                                                        obscureText: true,
                                                        validator:
                                                            Validator.password,
                                                        hint:
                                                            "Please enter your confirm password",
                                                        // validator: Validator.email,
                                                        controller:
                                                            confirmpassword),
                                                  ),
                                                  LoadingButton(
                                                    height: 35,
                                                    borderRadius: 8,
                                                    animate: true,
                                                    color: ThemeConstants
                                                        .bluecolor,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.44,
                                                    loader: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      width: 40,
                                                      height: 40,
                                                      child:
                                                          const CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    child:
                                                        CustomAutoSizeTextMontserrat(
                                                      text: 'Change Password',
                                                      textColor: ThemeConstants
                                                          .whitecolor,
                                                    ),
                                                    onTap: (startLoading,
                                                        stopLoading,
                                                        buttonState) async {
                                                      // print(widget.path);
                                                      if (buttonState ==
                                                          ButtonState.idle) {
                                                        startLoading();
                                                        if (confirmpassword
                                                                .text !=
                                                            password.text) {
                                                          getToast(
                                                              '${SnackBarConstants.passwordNotMatching}');
                                                        } else if (password
                                                                .text ==
                                                            confirmpassword
                                                                .text) {
                                                          print('object');
                                                          var res = await controller
                                                              .updatePassword(
                                                                  emailController
                                                                      .value
                                                                      .text,
                                                                  password
                                                                      .text);

                                                          if (res == true) {
                                                            await getToast(
                                                                '${SnackBarConstants.passwordUpdatedSuccessfully}');
                                                          }
                                                        }

                                                        stopLoading();
                                                        // await controller.otpcheck(
                                                        //     emailController.text,
                                                        //     otpfield.text);

                                                        // var res = await controller.logIn(
                                                        //     emailController.value.text,
                                                        //     password.value.text);

                                                        // if (res) {
                                                        //   controllerBase.user.value = res;
                                                        // }
                                                        // await download(widget.path);
                                                        // await Future.delayed(const Duration(seconds: 5))
                                                      }
                                                    },
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () async {
                                                  //     if (confirmpassword.text !=
                                                  //         password.text) {
                                                  //       return getToast(
                                                  //           'Password is not matching');
                                                  //     }
                                                  //     if (password.text ==
                                                  //         confirmpassword.text) {
                                                  //       controller.updatePassword(
                                                  //           emailController.value.text,
                                                  //           password.text);
                                                  //     }
                                                  //   },
                                                  //   child: Container(
                                                  //     height: 40,
                                                  //     width: MediaQuery.of(context)
                                                  //             .size
                                                  //             .width -
                                                  //         20,
                                                  //     decoration: BoxDecoration(
                                                  //         color: ThemeConstants.bluecolor,
                                                  //         borderRadius: BorderRadius.all(
                                                  //             Radius.circular(20.0))),
                                                  //     child: Center(
                                                  //       child:
                                                  //           CustomAutoSizeTextMontserrat(
                                                  //         text: "Register",
                                                  //         textColor:
                                                  //             ThemeConstants.whitecolor,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ]
                                              ]),
                                        ),
                                      )));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Forget password",
                                  style: TextStyle(
                                      color: ThemeConstants.bluecolor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     var res = await controller.logIn(
                          //         emailController.value.text, password.value.text);

                          //     if (res) {
                          //       controllerBase.user.value = res;
                          //     }
                          //     // Get.to(
                          //     //     () => CreatePasswrord(email: texfield.value.text));
                          //     // controller.otpcheck(texfield.text, otpfield.text);
                          //   },
                          //   child:
                          LoadingButton(
                            height: 35,
                            borderRadius: 8,
                            animate: true,
                            color: ThemeConstants.bluecolor,
                            width: MediaQuery.of(context).size.width * 0.44,
                            loader: Container(
                              padding: const EdgeInsets.all(10),
                              width: 40,
                              height: 40,
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            child: CustomAutoSizeTextMontserrat(
                              text: 'Sign in',
                              textColor: ThemeConstants.whitecolor,
                            ),
                            onTap:
                                (startLoading, stopLoading, buttonState) async {
                              // print(widget.path);
                              if (buttonState == ButtonState.idle) {
                                startLoading();
                                var res = await controller.logIn(
                                    emailController.value.text,
                                    password.value.text);

                                if (res != false) {
                                  controllerBase.user.value = res;
                                  Get.off(DashBoard());
                                }
                                // await download(widget.path);
                                // await Future.delayed(const Duration(seconds: 5))
                                stopLoading();
                              }
                            },
                          ),
                          //
                          //
                          // Container(
                          //   height: 40,
                          //   width: MediaQuery.of(context).size.width - 20,
                          //   decoration: BoxDecoration(
                          //       color: ThemeConstants.bluecolor,
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(20.0))),
                          //   child: Center(
                          //     child: CustomAutoSizeTextMontserrat(
                          //       text: "Submit",
                          //       textColor: ThemeConstants.whitecolor,
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offNamed(LoginPage.routeNamed);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Not registered? Click here",
                                  style: TextStyle(
                                      color: ThemeConstants.bluecolor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          onLoading: getLoading(context)),
    );
  }
}
