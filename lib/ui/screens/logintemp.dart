import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
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
      body: controller.obx(
          (state) => Container(
                decoration:
                    BoxDecoration(gradient: ThemeConstants.backgroundGradient),
                child: SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.3,
                        top: 0,
                        child: SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAutoSizeTextMontserrat(
                                  text: 'Welcome!',
                                  fontSize: 30,
                                  textColor: ThemeConstants.paleYellow,
                                ),
                                CustomAutoSizeTextMontserrat(
                                  text: "Lets's Register you",
                                  fontSize: 20,
                                  textColor: ThemeConstants.paleYellow,
                                )
                              ],
                            )),
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
                      Positioned(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 0.75,
                        top: 0,
                        child: SizedBox(
                            width: 350,
                            height: 350,
                            child:
                                Image.asset('assets/images/Login-Image.png')),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.93,
                          alignment: Alignment.bottomCenter,
                          child: Form(
                            key: controller.key,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  SizedBox(
                                    height: 0,
                                  ),
                                  // SizedBox(
                                  //     width: 350,
                                  //     height: 350,
                                  //     child:
                                  //         Image.asset('assets/images/Login-Image.png')),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: 'Register',
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                          controller
                                              .emailVerification(texfield.text);
                                        }

                                        //   email: texfield.text,
                                        // ));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: ThemeConstants.bluecolor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Verify Email",
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (controller.forOtp == 1 ||
                                      controller.forOtp == 2)
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
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
                                              vertical: 5, horizontal: 20),
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
                                                  color: controller.resendOTP ==
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
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: ThemeConstants.bluecolor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Verify OTP",
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (controller.otpSuccessful == 1) ...[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
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
                                      padding: const EdgeInsets.all(10.0),
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
                                      onTap: () async {
                                        if (confirmpassword.text !=
                                            password.text) {
                                          return getToast(
                                              '${SnackBarConstants.passwordNotMatching}');
                                        }

                                        //todo
                                        if (password.text ==
                                            confirmpassword
                                                .text) if (controller
                                            .key.currentState!
                                            .validate()) {
                                          var res =
                                              await controller.updatePassword(
                                                  texfield.value.text,
                                                  password.text);

                                          if (res) {
                                            context.go(DashBoard.routeNamed);
                                            // controller.onDelete();
                                            // Get.put(LoginController());
                                          }
                                        }
                                        {}
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: ThemeConstants.bluecolor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Center(
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Register",
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  GestureDetector(
                                    onTap: () {
                                      context.pop();
                                      // Get.offNamed(SignInView.route);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Already registered? Click here",
                                          style: TextStyle(
                                              color: ThemeConstants.blackcolor),
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
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          onLoading: getLoading(context)),
    );
  }
}
