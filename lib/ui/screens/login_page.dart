import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
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
                color: ThemeConstants.whitecolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomAutoSizeTextMontserrat(
                        text: 'Register',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          hint: "Enter your office email",
                          validator: Validator.email,
                          controller: texfield),
                    ),
                    if (controller.forOtp == 1 || controller.forOtp == 2)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextField(
                            hint: "enter your OTP",
                            validator: Validator.otp,
                            controller: otpfield),
                      ),

                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.startResend();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Resend OTP ${controller.timer.value}",
                              style: TextStyle(
                                  fontWeight: controller.resendOTP == 0
                                      ? FontWeight.w500
                                      : FontWeight.bold,
                                  color: controller.resendOTP == 0
                                      ? ThemeConstants.GreenColor
                                      : ThemeConstants.bluecolor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.verifyEmail == true)
                      InkWell(
                        onTap: () {
                          print('dd');
                          controller.emailVerification(texfield.text);

                          //   email: texfield.text,
                          // ));
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                              color: ThemeConstants.bluecolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: CustomAutoSizeTextMontserrat(
                              text: "Verify Email",
                              textColor: ThemeConstants.whitecolor,
                            ),
                          ),
                        ),
                      ),
                    if (controller.forOtp == 2)
                      InkWell(
                        onTap: () {
                          controller.otpcheck(texfield.text, otpfield.text);

                          // Get.to(CreatePasswrord(
                          //   email: texfield.text,
                          // ));
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                              color: ThemeConstants.bluecolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: CustomAutoSizeTextMontserrat(
                              text: "Verify OTP",
                              textColor: ThemeConstants.whitecolor,
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
                            obscureText: true,
                            validator: Validator.password,
                            hint: "Please enter your password",
                            // validator: Validator.email,
                            controller: password),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextField(
                            obscureText: true,
                            validator: Validator.password,
                            hint: "Please enter your confirm password",
                            // validator: Validator.email,
                            controller: confirmpassword),
                      ),
                      InkWell(
                        onTap: () async {
                          if (confirmpassword.text != confirmpassword.text) {
                            return getToast('Password is not matching');
                          }
                          if (password.text == confirmpassword.text) {
                            controller.updatePassword(
                                texfield.value.text, password.text);
                          } else {
                            getToast("Please check your password");
                          }
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                              color: ThemeConstants.bluecolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Center(
                            child: CustomAutoSizeTextMontserrat(
                              text: "Register",
                              textColor: ThemeConstants.whitecolor,
                            ),
                          ),
                        ),
                      ),
                    ],
                    GestureDetector(
                      onTap: () {
                        Get.to(SignInView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "Already registered? Click here",
                            style: TextStyle(color: ThemeConstants.bluecolor),
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
                  ],
                ),
              ),
          onLoading: getLoading(context)),
    );
  }
}
