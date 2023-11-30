import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/widget/backgroundLogin.dart';
import 'package:nice_loading_button/nice_loading_button.dart';

import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';

import 'package:meeting_module2/ui/controller/signin_controller.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class SignInView extends StatefulWidget {
  static const route = '/signin';
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  var controllerBase = Get.find<BaseController>();

  var controller = Get.put(SigninController());

  @override
  void dispose() {
    // controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController otpfield = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmpassword = TextEditingController();

  var emailController = TextEditingController();

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
                      // Positioned(
                      //     width: MediaQuery.of(context).size.width * 1,
                      //     height: MediaQuery.of(context).size.height * 0.7,
                      //     // bottom: 0,
                      //     top: MediaQuery.of(context).size.height * 0.3,
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           color: ThemeConstants.midVioltetColor,
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(180),
                      //             topRight: Radius.circular(180),
                      //           )),
                      //     )),
                      BackgroundAuthView(
                        text: "Let's organize your work...",
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          height: MediaQuery.of(context).size.height * 0.9,

                          alignment: Alignment.bottomCenter,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          child: Form(
                            key: controller.key,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SizedBox(
                                  //     height: 150,
                                  //     child: Column(
                                  //       mainAxisAlignment: MainAxisuuuuuiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiAlignment.end,
                                  //       children: [
                                  //         CustomAutoSizeTextMontserrat(
                                  //           text: 'Welcome!',
                                  //           fontSize: 30,
                                  //         ),
                                  //         CustomAutoSizeTextMontserrat(
                                  //           text: "Lets's Sign you in",
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
                                  //     child:
                                  //         Image.asset('assets/images/Login-Image.png')),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                                  //   child: CustomAutoSizeTextMontserrat(
                                  //     text: 'Sign In',
                                  //     textColor: ThemeConstants.whitecolor,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: CustomTextField(
                                        hint: "Enter your official email",
                                        validator: Validator.email,
                                        backgroundCOlour:
                                            ThemeConstants.whitecolor,
                                        controller: emailController),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: CustomTextField(
                                        obscureText: controller.showPassword,
                                        isPassword: true,
                                        callbackForPasswordShow: () {
                                          controller.showPassword =
                                              !controller.showPassword;
                                          controller.update();
                                        },
                                        hint: "Enter your password",
                                        backgroundCOlour:
                                            ThemeConstants.whitecolor,
                                        validator: Validator.notEmpty,
                                        controller: password),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // controller.getDailogForForget(
                                      //     context, emailController.text);

                                      showDialog(
                                        context: context,
                                        builder: (_) => Stack(children: [
                                          Center(
                                            child: AlertDialog(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child:
                                                                CustomAutoSizeTextMontserrat(
                                                              text:
                                                                  'Reset password',
                                                              fontSize:
                                                                  ThemeConstants
                                                                      .fontSizeMedium,
                                                              textColor:
                                                                  ThemeConstants
                                                                      .blackcolor,
                                                              fontWeight:
                                                                  ThemeConstants
                                                                      .fontWeightBold,
                                                            ),
                                                          ),
                                                          // Spacer(),
                                                          // InkWell(
                                                          //   onTap: () {
                                                          //     context.pop();
                                                          //   },
                                                          //   child: Container(
                                                          //     child: Icon(
                                                          //         Icons.close,
                                                          //         size: 18,
                                                          //         color: ThemeConstants
                                                          //             .blackcolor),
                                                          //   ),
                                                          // )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
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
                                                      if (controller
                                                              .verifyEmail ==
                                                          true)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      40,
                                                                  vertical: 2),
                                                          child: LoadingButton(
                                                            height: 35,
                                                            borderRadius: 8,
                                                            animate: true,
                                                            color:
                                                                ThemeConstants
                                                                    .bluecolor,
                                                            width: MediaQuery.of(
                                                                        context)
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
                                                                  CircularProgressIndicator(
                                                                valueColor: AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    ThemeConstants
                                                                        .bluecolor),
                                                              ),
                                                            ),
                                                            child:
                                                                CustomAutoSizeTextMontserrat(
                                                              text: 'Get OTP',
                                                              fontSize:
                                                                  ThemeConstants
                                                                      .fontSizeSmall,
                                                              textColor:
                                                                  ThemeConstants
                                                                      .whitecolor,
                                                            ),
                                                            onTap: (startLoading,
                                                                stopLoading,
                                                                buttonState) async {
                                                              // print(widget.path);
                                                              if (buttonState ==
                                                                  ButtonState
                                                                      .idle) {
                                                                startLoading();
                                                                if (emailController
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  var res = await controller.forgetPaasword(
                                                                      emailController
                                                                          .text,
                                                                      context);

                                                                  if (res) {
                                                                    context
                                                                        .pop();
                                                                    controller.getDailogForForget(
                                                                        context,
                                                                        emailController
                                                                            .text);
                                                                  }
                                                                } else {
                                                                  getToast(
                                                                      "Enter a vaild email");
                                                                }

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
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 30),
                                              child: GestureDetector(
                                                onTap: () {
                                                  context.pop();
                                                  // Get.back();
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: ThemeConstants
                                                          .bluecolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200)),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: ThemeConstants
                                                        .whitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 30),
                                        child: Text(
                                          "Forg\ot password?",
                                          style: ThemeConstants
                                              .montserratTextStyleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    loader: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                ThemeConstants.bluecolor),
                                      ),
                                    ),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: 'Sign in',
                                      fontSize: ThemeConstants.fontSizeMedium,
                                      textColor: ThemeConstants.whitecolor,
                                    ),
                                    onTap: (startLoading, stopLoading,
                                        buttonState) async {
                                      // print(widget.path);
                                      if (controller.key.currentState!
                                          .validate()) {
                                        if (buttonState == ButtonState.idle) {
                                          var res = await controller.logIn(
                                              emailController.value.text,
                                              password.value.text);

                                          //todo

                                          if (res != false) {
                                            // controllerBase.user.value = res;

                                            context.go(DashBoard.routeNamed);
                                            controllerBase.update();
                                          }
                                          // await download(widget.path);
                                          // await Future.delayed(const Duration(seconds: 5))
                                          stopLoading();
                                        }
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
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.push(LoginPage.routeNamed);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Don't have account? Register now",
                                          style: ThemeConstants
                                              .montserratTextStyleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
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
